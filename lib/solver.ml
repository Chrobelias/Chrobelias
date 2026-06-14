(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)
let trace_log fmt = Debug.trace "solver" fmt
let _config = Config.config
let _base = _config.enc_base

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
         let nfas =
           List.map
             (fun ir ->
                let nfa = eval ir in
                trace_log "Nfa for %a has %d nodes" Ir.pp ir (Nfa.length nfa);
                nfa |> do_if_lsb Nfa.reverse, ir)
             irs
           |> List.sort (fun (nfa1, _) (nfa2, _) -> Nfa.length nfa1 - Nfa.length nfa2)
         in
         let rec eval_and = function
           | (hd, _) :: [] -> hd
           | (hd, ir) :: (hd', ir') :: tl ->
             trace_log
               "Intersecting\n  [%d (%a)]\n  [%d (%a)]"
               (Nfa.length hd)
               Ir.pp
               ir
               (Nfa.length hd')
               Ir.pp
               ir';
             let nfa =
               Nfa.intersect hd hd'
               (* |> fun nfa ->
               if Ir.is_reg ir || Ir.is_reg ir' then Nfa.minimize nfa else nfa *)
             in
             let ir = Ir.land_ [ ir; ir' ] in
             let nfas =
               (nfa, ir) :: tl
               |> List.sort (fun (nfa1, _) (nfa2, _) -> Nfa.length nfa1 - Nfa.length nfa2)
             in
             eval_and nfas
           | [] -> NfaCollection.n ()
         in
         eval_and nfas
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
      | _ as ir -> List.find (fun (i, atom) -> Ir.equal atom ir) m |> fst |> AstL.get_pred
    in
    ( get_skeleton_exn atomics ir
    , atomics |> List.map (fun (i, atom) -> i, to_nfa atom) |> Map.of_alist_exn
    , vars )
  ;;

  let cache = ref Map.empty

  let eval ir =
    match Map.find !cache ir with
    | Some v -> v
    | None ->
      let v = eval ir in
      cache := Map.add_exn !cache ~key:ir ~data:v;
      v
  ;;

  (* Alessio, here essentially everything starts. 
  The formula from the input has been transformed into [ir] *)
  let get_model_nfa ir () =
    trace_log "Entered get_model_nfa";
    (* free_vars have type Ir.atom (only variables in LIA case; 
    can be exponentiated variables in EIA) *)
    let free_vars = ir |> Ir.collect_free_atoms |> Set.to_list in
    trace_log "Ir: %a" Ir.pp ir;
    if
      Config.config.bool_comb_sat
      (* We use complex acceptance condition for a list of nfas *)
    then (
      let skel, nfas, vars = ir |> eval_bool_comb in
      match
        Nfa.any_path_bool_comb
          skel
          nfas
          (List.map (fun v -> Map.find_exn vars v) free_vars)
      with
      | Some (model, _) ->
        Some (model |> List.mapi (fun i v -> List.nth free_vars i, v) |> Map.of_alist_exn)
      | None -> None)
    else (
      (* Classic parametric solving: with intersections and unions *)
      let nfa, vars = ir |> eval in
      match Nfa.any_path nfa (List.map (fun v -> Map.find_exn vars v) free_vars) with
      | Some (model, _) ->
        Some (model |> List.mapi (fun i v -> List.nth free_vars i, v) |> Map.of_alist_exn)
      | None -> None)
  ;;

  let check_sat ir
    : [ `Sat of unit -> ((Ir.atom, Nfa.v list) Map.t, [ `Too_long | `No_model ]) Result.t
      | `Unsat
      | `Unknown
      ]
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
      if Config.config.logic = `Par then ir else Ir.exists (free_vars |> Set.to_list) ir
    in
    Debug.trace "LICS" "Trying to use automatic decision procedure over %a\n" Ir.pp ir;
    match get_model_nfa ir' () with
    | Some model -> sat_if_no_unsupp (fun () -> Result.Ok model)
    | None -> `Unsat
  ;;
end

module MsbPar =
  Basic
    (Nfa.Parametric (Nfa.Par)) (NfaCollection.MsbPar)
    (struct
      module NfaO = Nfa
      module Par = Nfa.Par
      module NfaMsb = Nfa.Msb (Str)
      module NfaPar = Nfa.Parametric (Par)

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
    end)

let check_sat ir
  : [ `Sat of
        (Ir.atom, [ `Str | `Int ]) Map.t -> (Ir.model, [ `Too_long | `No_model ]) Result.t
    | `Unsat
    | `Unknown of Ir.t
    ]
  =
  let chack_par_sat ir =
    trace_log "Running parametric MSB mode";
    let ( let* ) = Result.bind in
    let int_of_path2 =
      let base = Z.of_int _base in
      function
      | 0 :: ds ->
        ds
        |> List.drop_while (fun x -> x = 0)
        |> List.fold_left (fun sum x -> Z.((base * sum) + of_int x)) Z.zero
      | d :: ds when d = _base - 1 ->
        ds
        |> List.drop_while (fun x -> x = _base - 1)
        |> List.fold_left
             (fun (sum, _pow) x -> Z.((base * sum) + of_int x), Z.(base * _pow))
             (Z.zero, Z.one)
        |> fun (num, _pow) -> Z.(num - _pow)
      | _ -> failwith "Unexpected symbols in int_of_path"
    in
    let str_of_path2 p =
      p |> List.drop 1 |> List.fold_left (fun acc c -> acc ^ Int.to_string c) ""
    in
    match MsbPar.check_sat ir with
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
                  begin try `Int (int_of_path2 v) with
                  | Invalid_argument ex as exp ->
                    Format.printf "Something is wrong: %s\n%!" (Printexc.to_string exp);
                    `Str (str_of_path2 v)
                  end
                | `Str -> `Str (str_of_path2 v))
              model
          in
          Result.ok main_model)
    | `Unsat -> `Unsat
    | `Unknown -> `Unknown ir
  in
  match Config.config.logic with
  | `Par -> chack_par_sat ir
  | _ -> failwith "Later..."
;;
