(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)
let trace_log fmt = Debug.trace "solver" fmt
let _config = Config.config
let _base = _config.enc_base

let ( -- ) i j =
  let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
  aux j []
;;

let do_if_range f = if _config.base_min < _config.base_max then f () else ()

module Set = Base.Set.Poly
module Map = Base.Map.Poly

let do_if_lsb f = if _config.mode = `Lsb then f else Fun.id
let level = ref 0

module NfaS = Nfa.Lsb (Nfa.Str)
module Str = Nfa.Str

module Basic
    (Nfa : Nfa.BasicType)
    (NfaCollection : NfaCollection.Type with type t = Nfa.t and type v = Nfa.v)
    (Eval : sig
       val bool_comb_handler
         :  AstL.t
         -> (int, Nfa.t) Map.t
         -> ('a, int) Map.t
         -> 'a list
         -> ('a, Nfa.v list) Map.t option list

       val handler
         :  Nfa.t
         -> ('a, int) Map.t
         -> 'a list
         -> ('a, Nfa.v list) Map.t option list

       val eval_sreg : (Ir.atom, int) Map.t -> Ir.atom -> char list Regex.t -> Nfa.t
       val eval_sregraw : (Ir.atom, int) Map.t -> Ir.atom -> NfaS.t -> Nfa.t
     end) =
struct
  let eval ir =
    let ir = Ir.antiprenex ir in
    let vars = Ir.collect_vars ir in
    (* Printf.printf "%s %d\n%!" __FILE__ __LINE__; *)
    let rec eval ir =
      if _config.dump_ir then Format.printf "%d Running %a\n%!" !level Ir.pp_smtlib2 ir;
      level := !level + 1;
      (match ir with
       | Ir.Unsupp s -> NfaCollection.n ()
       | Ir.True -> NfaCollection.n ()
       | Ir.Lnot ir -> eval ir |> Nfa.invert
       | Ir.Land irs ->
         (* Evaluate and intersect incrementally: compute one NFA at a time,
            intersect it with the accumulator, then force a GC to free the
            consumed NFA before moving to the next. This avoids keeping all
            leaf NFAs in memory simultaneously.
            Sort by estimated complexity (term count) to intersect smaller
            NFAs first. *)
         let irs =
           irs
           |> List.sort (fun a b -> Ir.approx_size a - Ir.approx_size b)
         in
         let intersect_and_free acc_nfa ir =
           let nfa = eval ir in
           trace_log "Nfa for %a has %d nodes" Ir.pp ir (Nfa.length nfa);
           let nfa = nfa |> do_if_lsb Nfa.reverse in
           trace_log
             "Intersecting\n  [%d]\n  [%d (%a)]"
             (Nfa.length acc_nfa)
             (Nfa.length nfa)
             Ir.pp
             ir;
           let result =
             Nfa.intersect acc_nfa nfa
             |> fun nfa ->
             if Nfa.length nfa <= _config.good_for_minimize
             then Nfa.minimize nfa
             else nfa
           in
           (* Force a full major GC to immediately free the large arrays
              of the consumed NFA (and the leaf NFA we just computed).
              Without this, major-heap arrays from previous iterations
              accumulate until the GC threshold is reached. *)
           Gc.full_major ();
           result
         in
         (match irs with
          | [] -> NfaCollection.n ()
          | first :: rest -> List.fold_left intersect_and_free (eval first |> do_if_lsb Nfa.reverse) rest)
         |> fun nfa ->
         trace_log "Intersect result %d" (Nfa.length nfa);
         nfa |> do_if_lsb Nfa.reverse
       | Ir.Lor (hd :: tl) ->
         List.fold_left (fun nfa ir -> eval ir |> Nfa.unite nfa) (eval hd) tl
       | Ir.Lor [] -> NfaCollection.z ()
       | Ir.Rel (rel, term, c) ->
         begin match rel with
         | Ir.Eq -> NfaCollection.eq vars term c
         | Ir.Leq -> NfaCollection.leq vars term c
         | Ir.Neq -> NfaCollection.neq vars term c
         end
       | Ir.V (var, pow) ->
         NfaCollection.buchi (Map.find_exn vars var) (Map.find_exn vars pow)
       | Ir.Exists (atoms, ir) ->
         let nfa =
           eval ir
           (*|> apply_post_strings atoms*)
           |> Nfa.project (List.filter_map (Map.find vars) atoms)
         in
         if Nfa.run nfa then NfaCollection.n () else NfaCollection.z ()
       | Ir.SReg (atom, reg) -> Eval.eval_sreg vars atom reg
       | Ir.SRegRaw (atom, reg) -> Eval.eval_sregraw vars atom reg
       | _ -> failwith "Unexpected constraint")
      |> fun nfa ->
      trace_log "Done %a" Ir.pp ir;
      Debug.dump_nfa
        ~msg:"Evaluated %s"
        ~pp_vars:
          (Format.pp_print_list
             ~pp_sep:(fun fmt () -> Format.fprintf fmt "\n")
             (fun fmt (a, b) -> Format.fprintf fmt "%d -> %a" b Ir.pp_atom a))
        ~vars:(Map.to_alist vars)
        Nfa.format_nfa
        nfa;
      level := !level - 1;
      nfa
    in
    let nfa = eval ir in
    (*let nfa = apply_post_strings ( Ir.collect_free ir |> Set.to_list in*)
    nfa, vars
  ;;

  (* Takes [ir] on input and returns 
  1) its Boolean skeleton; 2) a map with (num, nfa) for the atomic formulas; 
  3) a map with (num, var) with numbers of variables *)
  let eval_bool_comb ir =
    let vars = Ir.collect_vars ir in
    let to_nfa = function
      | Ir.Unsupp s -> NfaCollection.n ()
      | Ir.True -> NfaCollection.n ()
      | Ir.Rel (rel, term, c) ->
        begin match rel with
        | Ir.Eq -> NfaCollection.eq vars term c
        | Ir.Leq -> NfaCollection.leq vars term c
        | Ir.Neq -> NfaCollection.neq vars term c
        end
      | Ir.V (var, pow) ->
        NfaCollection.buchi (Map.find_exn vars var) (Map.find_exn vars pow)
      | Ir.SReg (atom, reg) -> Eval.eval_sreg vars atom reg
      | Ir.SRegRaw (atom, reg) -> Eval.eval_sregraw vars atom reg
      | _ -> failwith "Unexpected constraint"
    in
    let atomics =
      ir |> Ir.collect_atomics |> Set.to_list |> List.mapi (fun i atom -> i, atom)
    in
    let rec get_skeleton_exn m = function
      | Ir.Land irs -> AstL.land_ (List.map (get_skeleton_exn m) irs)
      | Ir.Lor irs -> AstL.lor_ (List.map (get_skeleton_exn m) irs)
      | Ir.Lnot ir -> AstL.lnot (get_skeleton_exn m ir)
      | _ as ir -> List.find (fun (i, atom) -> Ir.equal atom ir) m |> fst |> AstL.get_pred
    in
    ( get_skeleton_exn atomics ir
    , ( atomics
        |> List.map (fun (i, atom) -> i, to_nfa atom)
        |> Map.of_alist_exn
        |> fun nfas ->
           (* After building all atomic NFAs (which live in the major heap),
              force a full GC to free any intermediate NFAs created during
              evaluation. Without this, all leaf NFAs coexist in memory. *)
           Gc.full_major ();
           nfas )
    , vars )
  ;;

  (* Here essentially everything starts. 
  The formula from the input has been transformed into [ir] *)
  let get_model_nfa ir =
    trace_log "Entered get_model_nfa";
    (* free_vars have type Ir.atom (only variables in LIA case) *)
    let free_vars = ir |> Ir.collect_free_atoms |> Set.to_list in
    trace_log "Ir: %a" Ir.pp ir;
    if
      Config.config.bool_comb_sat
      (* We use complex acceptance condition for a list of nfas *)
    then (
      let skel, nfas, vars = ir |> eval_bool_comb in
      Eval.bool_comb_handler skel nfas vars free_vars)
    else (
      (* Classic Symbolic solving: with intersections and unions *)
      let nfa, vars = ir |> eval in
      Eval.handler nfa vars free_vars)
  ;;

  let check_sat ir
    : [ `Sat of unit -> ((Ir.atom, Nfa.v list) Map.t, [ `No_model ]) Result.t
      | `Unsat
      | `Unknown
      ]
        list
    =
    let had_unsupp =
      Ir.for_some
        (function
          | Ir.Unsupp _ -> true
          | _ -> false)
        ir
    in
    let sat_if_no_unsupp arg = if had_unsupp then `Unknown else `Sat arg in
    let free_vars = Ir.collect_free ir in
    let ir' =
      match Config.config.logic with
      | `Par | `Sym -> ir
      | _ -> Ir.exists (free_vars |> Set.to_list) ir
    in
    ir'
    |> get_model_nfa
    |> List.map (function
      | Some model ->
        if Map.is_empty model
        then `Sat (fun () -> Result.error `No_model)
        else sat_if_no_unsupp (fun () -> Result.Ok model)
      | None -> `Unsat)
  ;;
end

module MsbSym =
  Basic
    (Nfa.Symbolic (Nfa.Sym)) (NfaCollection.MsbSym)
    (struct
      module NfaO = Nfa
      module Sym = Nfa.Sym
      module NfaMsb = Nfa.Msb (Str)
      module NfaSym = Nfa.Symbolic (Sym)

      let eval_sreg (vars : (Ir.atom, int) Map.t) atom reg =
        let nfa = reg |> NfaS.of_regex |> NfaMsb.of_lsb |> NfaMsb.minimize_strong in
        let reenum = Map.find_exn vars atom in
        let nfa =
          nfa
          |> NfaO.convert_nfa_msb_sym (Map.singleton (Format.asprintf "lia%d" reenum) 0)
        in
        nfa
      ;;

      let eval_sregraw : (Ir.atom, int) Map.t -> Ir.atom -> NfaS.u -> NfaSym.t =
        fun vars atom reg ->
        let nfa = NfaMsb.of_lsb reg |> NfaMsb.minimize_strong in
        let reenum = Map.find_exn vars atom in
        let nfa =
          nfa
          |> NfaO.convert_nfa_msb_sym (Map.singleton (Format.asprintf "lin%d" reenum) 0)
        in
        nfa
      ;;

      let bool_comb_handler skel nfas vars free_vars =
        match
          NfaSym.any_path_bool_comb
            skel
            nfas
            (List.map (fun v -> Map.find_exn vars v) free_vars)
        with
        | Some (model, _) ->
          [ Some
              (model |> List.mapi (fun i v -> List.nth free_vars i, v) |> Map.of_alist_exn)
          ]
        | None -> [ None ]
      ;;

      let handler nfa vars free_vars =
        match NfaSym.any_path nfa (List.map (fun v -> Map.find_exn vars v) free_vars) with
        | Some (model, _) ->
          [ Some
              (model |> List.mapi (fun i v -> List.nth free_vars i, v) |> Map.of_alist_exn)
          ]
        | None -> [ None ]
      ;;
    end)

module MsbPar = struct
  module MsbPar =
    Basic
      (Nfa.Parametric (Nfa.Sym)) (NfaCollection.MsbPar)
      (struct
        module NfaO = Nfa
        module Sym = Nfa.Sym
        module NfaMsb = Nfa.Msb (Str)
        module NfaPar = Nfa.Parametric (Sym)

        let eval_sreg (vars : (Ir.atom, int) Map.t) atom reg =
          let nfa = reg |> NfaS.of_regex |> NfaMsb.of_lsb |> NfaMsb.minimize_strong in
          let reenum = Map.find_exn vars atom in
          let nfa =
            nfa
            |> NfaO.convert_nfa_msb_par (Map.singleton (Format.asprintf "lia%d" reenum) 0)
          in
          nfa
        ;;

        let eval_sregraw : (Ir.atom, int) Map.t -> Ir.atom -> NfaS.u -> NfaPar.t =
          fun vars atom reg ->
          let nfa = NfaMsb.of_lsb reg |> NfaMsb.minimize_strong in
          let reenum = Map.find_exn vars atom in
          let nfa =
            nfa
            |> NfaO.convert_nfa_msb_par (Map.singleton (Format.asprintf "lin%d" reenum) 0)
          in
          nfa
        ;;

        let bool_comb_handler skel nfas vars free_vars =
          _config.base_min -- _config.base_max
          |> List.map (fun base ->
            match
              NfaPar.any_path_bool_comb2
                ~base
                skel
                nfas
                (List.map (fun v -> Map.find_exn vars v) free_vars)
            with
            | Some (model, _) ->
              do_if_range (fun () -> Format.printf "base %d: sat\n%!" base);
              Some
                (model
                 |> List.mapi (fun i v -> List.nth free_vars i, v)
                 |> Map.of_alist_exn)
            | None ->
              do_if_range (fun () -> Format.printf "base %d: unsat\n%!" base);
              None)
        ;;

        let handler nfa vars free_vars =
          _config.base_min -- _config.base_max
          |> List.map (fun base ->
            match
              NfaPar.any_path2
                ~base
                nfa
                (List.map (fun v -> Map.find_exn vars v) free_vars)
            with
            | Some (model, _) ->
              do_if_range (fun () -> Format.printf "base %d: sat\n%!" base);
              Some
                (model
                 |> List.mapi (fun i v -> List.nth free_vars i, v)
                 |> Map.of_alist_exn)
            | None ->
              do_if_range (fun () -> Format.printf "base %d: unsat\n%!" base);
              None)
        ;;
      end)

  include MsbPar
end

let check_sat ir
  : [ `Sat of (Ir.atom, [ `Str | `Int ]) Map.t -> (Ir.model, [ `No_model ]) Result.t
    | `Unsat
    | `Unknown of Ir.t
    ]
      list
  =
  let int_of_path base =
    let baseZ = Z.of_int base in
    trace_log "Base in int_of_path: %a" Z.pp_print baseZ;
    function
    | 0 :: ds ->
      ds
      |> List.drop_while (fun x -> x = 0)
      |> List.fold_left (fun sum x -> Z.((baseZ * sum) + of_int x)) Z.zero
    | d :: ds when d = base - 1 ->
      ds
      |> List.drop_while (fun x -> x = base - 1)
      |> List.fold_left
           (fun (sum, _pow) x -> Z.((baseZ * sum) + of_int x), Z.(baseZ * _pow))
           (Z.zero, Z.one)
      |> fun (num, _pow) -> Z.(num - _pow)
    | [] -> failwith "Empty list of symbols in int_of_path"
    | _ -> failwith "Unexpected symbols in int_of_path"
  in
  let str_of_path p =
    p |> List.drop 1 |> List.fold_left (fun acc c -> acc ^ Int.to_string c) ""
  in
  let chack_sym_sat ir =
    trace_log "Running Symbolic MSB mode";
    let ( let* ) = Result.bind in
    _config.base_min -- _config.base_max
    |> List.concat_map (fun base ->
      Config.config.enc_base <- base;
      let result =
        ir
        |> MsbSym.check_sat
        |> List.map (function
          | `Sat model ->
            do_if_range (fun () -> Format.printf "base %d: sat\n%!" base);
            `Sat
              (fun tys ->
                let* model = model () in
                let main_model =
                  Map.mapi
                    ~f:(fun ~key:k ~data:v ->
                      let ty = Map.find tys k |> Option.value ~default:`Int in
                      match ty with
                      | `Int ->
                        begin try `Int (int_of_path base v) with
                        | Invalid_argument ex as exp ->
                          Format.printf
                            "Something is wrong: %s\n%!"
                            (Printexc.to_string exp);
                          `Str (str_of_path v)
                        end
                      | `Str -> `Str (str_of_path v))
                    model
                in
                Result.ok main_model)
          | `Unsat ->
            do_if_range (fun () -> Format.printf "base %d: unsat\n%!" base);
            `Unsat
          | `Unknown -> failwith "Unexpected 'unknown' in chack_sym_sat")
      in
      (* Free the large NFA arrays from this base before processing the next *)
      Gc.full_major ();
      result)
  in
  let chack_par_sat ir =
    trace_log "Running Parametric MSB mode";
    let ( let* ) = Result.bind in
    ir
    |> MsbPar.check_sat
    |> List.mapi (fun i -> function
      | `Sat model ->
        `Sat
          (fun tys ->
            let* model = model () in
            let main_model =
              Map.mapi
                ~f:(fun ~key:k ~data:v ->
                  let ty = Map.find tys k |> Option.value ~default:`Int in
                  match ty with
                  | `Int ->
                    begin try `Int (int_of_path (i + _config.base_min) v) with
                    | Invalid_argument ex as exp ->
                      Format.printf "Something is wrong: %s\n%!" (Printexc.to_string exp);
                      `Str (str_of_path v)
                    end
                  | `Str -> `Str (str_of_path v))
                model
            in
            Result.ok main_model)
      | `Unsat -> `Unsat
      | `Unknown -> `Unknown ir)
  in
  match Config.config.logic with
  | `Sym -> chack_sym_sat ir
  | `Par -> chack_par_sat ir
  | _ -> failwith "Later..."
;;
