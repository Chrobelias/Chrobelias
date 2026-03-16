(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2026, Chrobelias. *)

module Set = Base.Set.Poly
module Map = Base.Map.Poly

let trace_log fmt = Debug.trace "solver" fmt

type t =
  { vars : (Ir.atom, int) Map.t
  ; internal_counter : int
  }

exception Too_long_model

let internal s =
  let len = s.vars |> Map.data |> List.fold_left Int.max 0 in
  let c = Ir.internal () in
  let s =
    { internal_counter = s.internal_counter + 1
    ; vars = Map.add_exn s.vars ~key:c ~data:(s.internal_counter + len + 1)
    }
  in
  c, s
;;

let get_exp = Ir.get_exp

let ( -- ) i j =
  let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
  aux j []
;;

let do_if_msb f = if Config.config.mode = `Msb then f else Fun.id
let do_if_lsb f = if Config.config.mode = `Lsb then f else Fun.id

let strbv_to_char =
  let module StrBv = Nfa.StrBv (Nfa.Base10) in
  let module Str = Nfa.Str (Nfa.Base10) in
  function
  | c when c = StrBv.u_eos -> Str.u_eos
  | c when c = StrBv.u_null -> '0'
  | c -> Z.log2 c |> fun i -> Char.chr (Char.code '0' + i)
;;

let char_to_strbv =
  let module StrBv = Nfa.StrBv (Nfa.Base10) in
  let module Str = Nfa.Str (Nfa.Base10) in
  function
  | '0' .. '9' as c -> Z.pow (Z.of_int 2) (Char.code c - Char.code '0')
  | c when c = Str.u_eos -> StrBv.u_eos
  | c when c = Str.u_null -> StrBv.u_null
  | _ -> assert false
;;

let aux_of_path
      (type a)
      (module Label : Nfa.L with type u = a)
      ?(mode : [ `Lsb | `Msb ] option)
      ?(no_sign = false)
      number
  : [ `Plus | `Minus ] * a List.t
  =
  let mode = Option.value mode ~default:Config.config.mode in
  let sign, number =
    match mode, no_sign with
    | `Lsb, true -> `Plus, List.rev number
    | `Lsb, false ->
      let number = List.rev number in
      begin match number with
      | hd :: tl when hd = Label.u_zero || hd = Label.u_eos -> `Plus, tl
      | hd :: tl -> `Minus, tl
      | _ -> assert false
      end
    | `Msb, true -> `Plus, number
    | `Msb, false ->
      begin match number with
      | hd :: tl when hd = Label.u_zero || hd = Label.u_eos -> `Plus, tl
      | hd :: tl -> `Minus, tl
      | _ -> assert false
      end
  in
  let number =
    number
    |> List.drop_while (fun c -> c = Label.u_eos)
    |> List.map (fun c -> if c = Label.u_null || c = Label.u_eos then Label.u_zero else c)
  in
  sign, number
;;

let int_of_path
      (type a)
      (module Label : Nfa.L with type u = a)
      ?(mode : [ `Lsb | `Msb ] option)
      (f : a List.t -> Z.t)
      ?(negate_symbol : (a -> a) option)
      path
  =
  let sign, path =
    aux_of_path (module Label) ?mode ~no_sign:(negate_symbol |> Option.is_none) path
  in
  match sign with
  | `Plus -> f path
  | `Minus ->
    let negate_symbol = Option.get negate_symbol in
    path |> List.map negate_symbol |> f |> fun x -> Z.(-x - one)
;;

let string_of_path
      (type a)
      (module Label : Nfa.L with type u = a)
      ?(mode : [ `Lsb | `Msb ] option)
      (f : a List.t -> string)
      path
  =
  let sign, path = aux_of_path (module Label) ?mode ~no_sign:true path in
  match sign with
  | `Plus -> f path
  | _ -> assert false
;;

(* The following functions assume MSB input. *)
let z_of_char_list p = p |> List.to_seq |> String.of_seq |> Z.of_string

let z_of_strbv_list p =
  p |> List.map strbv_to_char |> List.to_seq |> String.of_seq |> Z.of_string
;;

let string_of_char_list p = p |> List.to_seq |> String.of_seq

let z_of_bool_list p =
  let p = List.rev p in
  let length = List.length p in
  let bv_init deg f =
    List.fold_left
      (fun acc v -> if f v then Z.logor acc (Z.shift_left Z.one v) else acc)
      Z.zero
      (0 -- (deg - 1))
  in
  bv_init length (fun i -> List.nth p i)
;;

let char_negate c = Char.chr (Char.code '0' + (Char.code '9' - Char.code c))
let strbv_negate c = strbv_to_char c |> char_negate |> char_to_strbv

open Config

let level = ref 0

module Str = Nfa.Str
module NfaO = Nfa

module Make
    (NfaNat : Nfa.NatType)
    (NfaCollectionNat : NfaCollection.NatType with type t = NfaNat.t)
    (Nfa : Nfa.Type with type u = NfaNat.t and type v = NfaNat.v)
    (NfaCollection : NfaCollection.Type with type t = Nfa.t and type v = Nfa.v)
    (Extra : sig
       val eval_sreg : (Ir.atom, int) Map.t -> Ir.atom -> char list Regex.t -> Nfa.t
       val eval_sregraw : (Ir.atom, int) Map.t -> Ir.atom -> NfaO.String.t -> Nfa.t
       val eval_reg : (Ir.atom, int) Map.t -> bool list Regex.t -> Ir.atom list -> Nfa.t

       (*val model_to_int : Nfa.v list -> Z.t*)
       val nat_model_to_int : NfaNat.v list -> Z.t
       val nat_model_to_model : NfaNat.v list -> Nfa.v list
       val int_to_model : Z.t -> Nfa.v list
     end) =
struct
  let is_exp = Ir.is_exp

  let eval ir =
    let ir = Ir.antiprenex ir in
    let alpha = None in
    let vars = Ir.collect_vars ir in
    (* Printf.printf "%s %d\n%!" __FILE__ __LINE__; *)
    let rec eval ir =
      if Config.config.dump_ir
      then Format.printf "%d Running %a\n%!" !level Ir.pp_smtlib2 ir;
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
                trace_log "Nfa for %a has %d nodes\n%!" Ir.pp ir (Nfa.length nfa);
                nfa |> do_if_lsb Nfa.reverse, ir)
             irs
           |> List.sort (fun (nfa1, _) (nfa2, _) -> Nfa.length nfa1 - Nfa.length nfa2)
         in
         let rec eval_and = function
           | (hd, _) :: [] -> hd
           | (hd, ir) :: (hd', ir') :: tl ->
             trace_log
               "Intersecting\n  [%d (%a)]\n  [%d (%a)]\n%!"
               (Nfa.length hd)
               Ir.pp
               ir
               (Nfa.length hd')
               Ir.pp
               ir';
             let nfa = Nfa.intersect hd hd' in
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
         trace_log "Intersect result %d \n%!" (Nfa.length nfa);
         nfa |> do_if_lsb Nfa.reverse
       | Ir.Lor (hd :: tl) ->
         List.fold_left (fun nfa ir -> eval ir |> Nfa.unite nfa) (eval hd) tl
       | Ir.Lor [] -> NfaCollection.z ()
       | Ir.Rel (rel, term, c) ->
         begin match rel with
         | Ir.Eq ->
           let nfa = NfaCollection.eq vars term c in
           let nfa =
             Map.fold
               ~init:nfa
               ~f:(fun ~key:k ~data:v acc ->
                 (* TODO: this can (and should) be placed inside NfaCollection. *)
                 if Map.mem term k && is_exp k
                 then
                   acc
                   |> Nfa.intersect
                        (NfaCollection.power_of_two v |> do_if_msb Nfa.minimize_strong)
                   |> do_if_msb Nfa.minimize_not_very_strong
                 else acc)
               vars
           in
           nfa
         | Ir.Leq ->
           let nfa = NfaCollection.leq vars term c in
           let nfa =
             Map.fold
               ~init:nfa
               ~f:(fun ~key:k ~data:v acc ->
                 (* TODO: this can (and should) be placed inside NfaCollection. *)
                 if Map.mem term k && is_exp k
                 then
                   acc
                   |> Nfa.intersect
                        (NfaCollection.power_of_two v |> do_if_msb Nfa.minimize_strong)
                   |> do_if_msb Nfa.minimize_not_very_strong
                 else acc)
               vars
           in
           nfa
         | Ir.Neq ->
           let nfa = NfaCollection.neq vars term c in
           let nfa =
             Map.fold
               ~init:nfa
               ~f:(fun ~key:k ~data:v acc ->
                 (* TODO: It seems ensuring the variables are powers is really important here. *)
                 if Map.mem term k && is_exp k
                 then
                   acc
                   |> Nfa.intersect
                        (NfaCollection.power_of_two v |> do_if_msb Nfa.minimize_strong)
                   |> do_if_msb Nfa.minimize_not_very_strong
                 else acc)
               vars
           in
           nfa
         end
       | Ir.Reg (reg, atoms) -> Extra.eval_reg vars reg atoms
       | Ir.Exists (atoms, ir) ->
         let latest_var = Set.equal (Ir.collect_free ir) (Set.of_list atoms) in
         let nfa =
           eval ir
           (*|> apply_post_strings atoms*)
           |> Nfa.project (List.filter_map (Map.find vars) atoms)
         in
         if not latest_var
         then Nfa.minimize nfa
         else if Nfa.run nfa
         then NfaCollection.n ()
         else NfaCollection.z ()
       | Ir.SReg (atom, reg) ->
         Extra.eval_sreg vars atom reg
         |> fun nfa ->
         trace_log "(c, d)%!";
         Seq.iter
           (fun (c, d) -> trace_log "(%d, %d)%!" c d)
           (NfaNat.chrobak (nfa |> Nfa.to_nat));
         nfa
       | Ir.SRegRaw (atom, reg) -> Extra.eval_sregraw vars atom reg
       | Ir.SLen (atom, atom') ->
         NfaCollection.strlen
           ~alpha
           ~dest:(Map.find_exn vars atom')
           ~src:(Map.find_exn vars atom)
           ()
       | _ -> failwith "unexpected due to Arithmetization")
      |> fun nfa ->
      trace_log "Done %a%!" Ir.pp ir;
      Debug.dump_nfa ~msg:"Evaluated %s" ~vars:(Map.to_alist vars) Nfa.format_nfa nfa;
      level := !level - 1;
      nfa
    in
    let nfa = eval ir in
    (*let nfa = apply_post_strings ( Ir.collect_free ir |> Set.to_list in*)
    nfa, vars
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

  let logBase n = Utils.logBase n ~base:NfaCollection.base
  let logBaseZ n = Utils.logBaseZ n ~base:NfaCollection.base

  let pow2z n =
    List.init (Z.to_int n) (Fun.const NfaCollection.base) |> List.fold_left Z.( * ) Z.one
  ;;

  let to_exp = function
    | Ir.Pow2 _ -> failwith "Expected var"
    | Ir.Var var -> Ir.pow2 var
  ;;

  let decide_order vars =
    let rec perms list =
      let a =
        if list <> []
        then
          List.mapi
            (fun i el ->
               let list = List.filteri (fun j _ -> i <> j) list in
               List.map (fun list' -> el :: list') (perms list))
            list
          |> List.concat
        else [ [] ]
      in
      a
    in
    let perms = perms (Map.keys vars) in
    perms
    |> List.filter (fun perm ->
      Base.List.for_alli
        ~f:(fun i var ->
          if is_exp var
          then (
            let x = get_exp var in
            List.find_index (fun y -> x = y) perm |> Option.value ~default:9999999 > i)
          else true)
        perm)
    |> List.filter (fun perm ->
      Base.List.for_alli
        ~f:(fun exi ex ->
          if is_exp ex
          then (
            let x = get_exp ex in
            match List.find_index (fun x' -> x = x') perm with
            | Some xi ->
              Base.List.for_alli
                ~f:(fun eyi ey ->
                  if is_exp ey && eyi > exi
                  then (
                    let y = get_exp ey in
                    match List.find_index (fun y' -> y = y') perm with
                    | Some yi -> yi > xi
                    | None -> true)
                  else true)
                perm
            | None -> true)
          else true)
        perm)
  ;;

  let nfa_for_exponent2 s var var2 chrob =
    let module Nfa = NfaNat in
    let module NfaCollection = NfaCollectionNat in
    Debug.trace
      "LICS"
      "nfa_for_exponent2: internal_counter=%d var=%a var2=%a\n%!"
      s.internal_counter
      Ir.pp_atom
      var
      Ir.pp_atom
      var2;
    chrob
    |> Seq.map (fun (a, c) ->
      if c = 0
      then (
        let poly = Map.of_alist_exn [ var, Z.one; var2, Z.minus_one ] in
        let nfa = NfaCollection.eq s.vars poly (Z.of_int a) in
        (* var = var2 + a*)
        Debug.trace
          "LICS"
          "nfa_for_exponent2: we have %a = %a + %d\n%!"
          Ir.pp_atom
          var
          Ir.pp_atom
          var2
          a;
        Debug.dump_nfa ~msg:"nfa_for_exponent2 output nfa: %s" Nfa.format_nfa nfa;
        nfa)
      else (
        let t, s = internal s in
        (* let t_non_neg =
            NfaCollection.leq s.vars (Map.of_alist_exn [ t, Z.minus_one ]) Z.zero
          in *)
        let poly = Map.of_alist_exn [ var, Z.one; var2, Z.minus_one; t, Z.of_int (-c) ] in
        let nfa =
          NfaCollection.eq s.vars poly (Z.of_int a)
          (* var = var2 + a + c * t *)
          (* |> Nfa.intersect t_non_neg t >= 0 (* We are assuming to work only with non-negative integers*)*)
          |> Nfa.project [ Map.find_exn s.vars t ]
        in
        Debug.trace
          "LICS"
          "nfa_for_exponent2: we have Et : %a = %a + %d + %d * t\n%!"
          Ir.pp_atom
          var
          Ir.pp_atom
          var2
          a
          c;
        Debug.dump_nfa ~msg:"nfa_for_exponent2 output nfa: %s" Nfa.format_nfa nfa;
        nfa))
  ;;

  let nfa_for_exponent s var newvar chrob =
    let module Nfa = NfaNat in
    let module NfaCollection = NfaCollectionNat in
    let bound_res = Config.config.bound_res in
    let segm c =
      if bound_res >= 0 && bound_res < c
      then (
        Config.bounded_unsat := true;
        0 -- (bound_res - 1))
      else 0 -- (c - 1)
    in
    let get_deg = Map.find_exn s.vars in
    chrob
    |> Seq.concat_map (fun (a, c) ->
      if c = 0
      then
        Seq.init (a + 10) (( + ) a)
        |> Seq.filter (fun x -> x - logBase x = a)
        |> Seq.map (fun a' ->
          let poly = Map.of_alist_exn [ var, Z.one ] in
          let nfa = NfaCollection.eq s.vars poly (Z.of_int a') in
          (*var = a'*)
          Debug.trace
            "LICS"
            "nfa_for_exponent: we have %a = log(%a) + %d ~~> %a = %d\n%!"
            Ir.pp_atom
            var
            Ir.pp_atom
            var
            a
            Ir.pp_atom
            var
            a';
          Debug.dump_nfa
            ~msg:"nfa_for_exponent output nfa: %s"
            Nfa.format_nfa
            nfa
            ~vars:[ var, get_deg var ];
          nfa)
      else
        segm c
        |> List.map (fun d -> a, d, c)
        |> List.to_seq
        |> Seq.map (fun (a, d, c) ->
          let t, s = internal s in
          let get_deg = Map.find_exn s.vars in
          let poly = Map.of_alist_exn [ t, Z.of_int (-c); var, Z.one ] in
          let nfa' = NfaCollection.eq s.vars poly (Z.of_int (a + d)) in
          let nfa = Nfa.project [ get_deg t ] nfa' in
          (*var = a + d + c * t*)
          let n =
            List.init (a + 10) (( + ) a)
            |> List.filter (fun x -> x - logBase x >= a)
            |> List.hd
          in
          Debug.trace
            "LICS"
            "nfa_for_exponent: we have Et : %a = %d + %d + %d*t \n%!"
            Ir.pp_atom
            var
            a
            d
            c;
          Debug.dump_nfa ~msg:"nfa_for_exponent var nfa: %s" Nfa.format_nfa nfa;
          let newvar_nfa = NfaCollection.div_in_pow newvar d c in
          Debug.dump_nfa ~msg:"nfa_for_exponent div_in_pow: %s" Nfa.format_nfa newvar_nfa;
          let poly = Map.of_alist_exn [ var, Z.minus_one ] in
          let geq_nfa = NfaCollection.leq s.vars poly (Z.of_int (-n)) in
          Debug.dump_nfa ~msg:"nfa_for_exponent geq_nfa: %s" Nfa.format_nfa geq_nfa;
          let nfa =
            nfa |> Nfa.intersect geq_nfa |> Nfa.intersect newvar_nfa |> Nfa.minimize
          in
          Debug.dump_nfa
            ~msg:"nfa_for_exponent output nfa: %s"
            Nfa.format_nfa
            nfa
            ~vars:[ var, get_deg var; Ir.var "newvar", newvar ];
          nfa))
  ;;

  let project_exp s nfa x next =
    let module Nfa = NfaNat in
    let module NfaCollection = NfaCollectionNat in
    Debug.dump_nfa
      ~msg:"Nfa inside project_exp: %s"
      ~vars:(Map.to_alist s.vars)
      Nfa.format_nfa
      nfa;
    let vars = s.vars |> Map.filter_keys ~f:Ir.is_var |> Map.data in
    let inter, s = internal s in
    let get_deg = Map.find_exn s.vars in
    let x' = get_exp x in
    trace_log
      "vars: [%a]"
      (Format.pp_print_list ~pp_sep:Format.pp_print_space Format.pp_print_int)
      vars;
    if is_exp next
    then
      nfa
      |> Nfa.get_chrobaks_sub_nfas
           ~res:(get_deg x)
           ~temp:(get_deg next)
           ~vars
           ~no_model:Config.config.no_model
      |> Seq.flat_map (fun (nfa, chrobak, model_part) ->
        (let y = get_exp next in
         Debug.dump_nfa
           ~msg:"close to nfa_for_exponent2 - intersection nfa: %s"
           Nfa.format_nfa
           nfa;
         nfa_for_exponent2 s x' y chrobak)
        |> Seq.map (Nfa.intersect nfa)
        |> Seq.map (fun nfa -> nfa, model_part))
    else (
      let nfa =
        nfa
        |> Nfa.intersect
             (NfaCollection.pow_of_log_var (get_deg x') (get_deg inter)
              |> fun nfa ->
              Debug.dump_nfa ~msg:"pow_of_log_var: %s" Nfa.format_nfa nfa;
              nfa)
      in
      Debug.dump_nfa ~msg:"Nfa intersected with pow_of_log_var: %s" Nfa.format_nfa nfa;
      nfa
      |> Nfa.get_chrobaks_sub_nfas
           ~res:(get_deg x)
           ~temp:(get_deg inter)
           ~vars
           ~no_model:Config.config.no_model
      |> Seq.flat_map (fun (nfa, chrobak, model_part) ->
        nfa_for_exponent s x' (get_deg inter) chrobak
        |> Seq.map (Nfa.intersect nfa)
        |> Seq.map (fun nfa -> nfa, model_part))
      |> Seq.map (fun (nfa, model_part) -> Nfa.project [ get_deg inter ] nfa, model_part))
  ;;

  let proof_order return project s nfa order =
    let module Nfa = NfaNat in
    let module NfaCollection = NfaCollectionNat in
    let get_deg = Map.find_exn s.vars in
    let rec helper nfa remaining_order model =
      Debug.trace
        "LICS"
        "<><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>\n%!";
      Debug.dump_nfa
        ~msg:"Nfa inside proof_order: %s"
        ~vars:(Map.to_alist s.vars)
        Nfa.format_nfa
        nfa;
      match remaining_order with
      | [] -> return s order nfa model
      | x :: [] -> return s order (project (get_deg x) nfa) model
      | x :: (next :: _ as tl) ->
        if not (is_exp x)
        then helper (project (get_deg x) nfa) tl model
        else (
          let x' = get_exp x in
          let num_of_exp = tl |> List.filter (fun var -> is_exp var) |> List.length in
          let x_eq_1_model =
            if num_of_exp == 0
            then (
              Debug.trace "LICS" "We are trying zeros for %a\n%!" Ir.pp_atom x';
              let zero_nfa =
                List.fold_left
                  (fun nfa y' ->
                     let y'_eq_0 =
                       NfaCollection.eq s.vars (Map.singleton y' Z.one) Z.zero
                     in
                     Nfa.intersect nfa y'_eq_0)
                  (NfaCollection.eq s.vars (Map.singleton x Z.one) Z.one)
                  tl
              in
              let model_with_zeros = (fun _ -> Some ([], 0)) :: model in
              return s order (Nfa.intersect nfa zero_nfa) model_with_zeros)
            else None
          in
          match x_eq_1_model with
          | Some model -> Option.some model
          | None ->
            project_exp s nfa x next
            |> Seq.map (fun (nfa, model_part) ->
              helper (project (get_deg x) nfa) tl (model_part :: model))
            |> Seq.find_map Fun.id)
    in
    helper nfa order []
  ;;

  let prepare_order s ir nfa order =
    let ( let* ) = Option.bind in
    Debug.trace
      "LICS"
      "\n\n\nTrying order %a\n%!"
      (Format.pp_print_list ~pp_sep:(fun ppf () -> Format.fprintf ppf " <= ") Ir.pp_atom)
      (order |> List.rev);
    let len = List.length order in
    let* nfa =
      if len <= 1
      then Some nfa
      else (
        let order_ir =
          Seq.zip
            (order |> List.to_seq |> Seq.take (len - 1))
            (order |> List.to_seq |> Seq.drop 1)
          |> Seq.map (fun (x, y) ->
            let term = [ x, Z.one; y, Z.minus_one ] |> Map.of_alist_exn in
            if is_exp x && (not (is_exp y)) && get_exp x = y
            then Ir.gt term Z.zero
            else Ir.geq term Z.zero)
          |> List.of_seq
          |> function
          | [] -> failwith ""
          | comps -> Ir.land_ comps
        in
        let* () =
          match Overapprox.check (Me.eia_of_ir (Ir.land_ [ ir; order_ir ])) with
          | `Unknown ast -> Some ()
          | `Unsat -> None
          | _ -> Some ()
        in
        let order_nfa, order_vars = eval order_ir in
        Debug.dump_nfa ~msg:"Nfa order1: %s" Nfa.format_nfa order_nfa;
        order_vars
        |> Map.map_keys_exn ~f:(fun k -> Map.find_exn s.vars k)
        |> Map.iteri ~f:(fun ~key ~data -> trace_log "   %d -> %d" key data);
        let order_nfa =
          order_nfa
          |> Nfa.to_nat
          |> NfaNat.reenumerate
               (order_vars |> Map.map_keys_exn ~f:(fun k -> Map.find_exn s.vars k))
        in
        Debug.dump_nfa ~msg:"Nfa order2: %s" NfaNat.format_nfa order_nfa;
        Some (NfaNat.intersect nfa (order_nfa |> NfaNat.minimize)))
    in
    Debug.dump_nfa ~msg:"NFA taking order into account: %s" NfaNat.format_nfa nfa;
    Some (order, nfa)
  ;;

  let eval_semenov return next formula =
    (* if
      Ast.for_some
        (function
          | Ast.Any (_, _) | Ast.Exists (_, _) -> true
          | _ -> false)
        (fun _ -> false)
        formula
    then
      Format.printf
        "Semënov arithmetic formula contains quantifiers not on the top-level. In general such \
         formulas might be undecidable. We still try to evaluate them though to try out the \
         limitations of the algorithm.\n\
         %!"; *)
    let vars = Ir.collect_vars formula in
    let formula =
      formula
      |> Ir.exists
           (vars
            |> Map.keys
            |> List.filter (fun var ->
              (not (is_exp var)) && not (Map.mem vars (to_exp var))))
    in
    let nfa, vars = eval formula in
    let nfa = Nfa.minimize nfa in
    Debug.dump_nfa
      ~msg:"Minimized raw original nfa: %s"
      ~vars:(Map.to_alist vars)
      Nfa.format_nfa
      nfa;
    let nfa =
      Map.fold
        ~init:nfa
        ~f:(fun ~key:k ~data:v acc ->
          if is_exp k
          then
            acc
            |> Nfa.intersect
                 (NfaCollection.power_of_two v |> do_if_msb Nfa.minimize_strong)
            |> do_if_msb Nfa.minimize_not_very_strong
          else acc)
        vars
    in
    Debug.dump_nfa
      ~msg:"Minimized raw2 original nfa: %s"
      ~vars:(Map.to_alist vars)
      Nfa.format_nfa
      nfa;
    let nfa =
      Map.fold
        ~f:(fun ~key:k ~data:v acc ->
          if is_exp k
          then acc
          else if Map.mem vars (to_exp k) |> not
          then Nfa.project [ v ] acc
          else acc)
        ~init:nfa
        vars
    in
    Debug.dump_nfa
      ~msg:"Minimized raw3 original nfa: %s"
      ~vars:(Map.to_alist vars)
      Nfa.format_nfa
      nfa;
    let atoms = Ir.collect_atoms formula in
    let nfa =
      Set.fold
        ~f:(fun acc k ->
          if is_exp k && not (Set.mem atoms (get_exp k))
          then Nfa.project [ Map.find_exn vars k ] acc
          else acc)
        ~init:nfa
        atoms
    in
    let nfa = nfa |> Nfa.to_nat in
    Debug.dump_nfa
      ~msg:"Minimized original nfa: %s"
      ~vars:(Map.to_alist vars)
      NfaNat.format_nfa
      nfa;
    let powered_vars =
      Map.filteri
        ~f:(fun ~key:k ~data:_ ->
          (is_exp k && Set.mem atoms (get_exp k))
          || ((not (is_exp k)) && Set.mem atoms k && Set.mem atoms (to_exp k)))
        vars
    in
    let s = { vars = powered_vars; internal_counter = 0 } in
    decide_order powered_vars
    |> List.to_seq
    |> Seq.filter_map (prepare_order s formula nfa)
    (*Filtering of orderings w.r.t. the simple overapproximation idea:
      1) exponent is a power of the base;
      2) exp(base, x) >= (base -1)*x + 1
    *)
    |> (if not Config.config.over_nfa
        then Fun.id
        else
          Seq.filter (function order, nfa ->
              let exp_vars =
                powered_vars |> Map.keys |> List.filter (fun x -> is_exp x)
              in
              if List.length exp_vars > 1
              then (
                let nfa_with_over =
                  nfa
                  |> List.fold_right
                       NfaNat.intersect
                       (exp_vars
                        |> List.map (fun x ->
                          let over_x =
                            Map.of_alist_exn
                              [ x, Z.minus_one
                              ; (get_exp x, Z.(of_int !Config.base - one))
                              ]
                          in
                          Nfa.to_nat (NfaCollection.leq powered_vars over_x Z.minus_one))
                       )
                in
                Debug.dump_nfa
                  ~msg:"Overapproxed nfa: %s"
                  ~vars:(Map.to_alist vars)
                  NfaNat.format_nfa
                  nfa_with_over;
                let nfa_to_check =
                  nfa_with_over
                  |> NfaNat.project
                       (order |> List.map (fun str -> Map.find_exn s.vars str))
                in
                Debug.dump_nfa
                  ~msg:"Checking if solvable: %s"
                  NfaNat.format_nfa
                  nfa_to_check;
                nfa_to_check |> NfaNat.run)
              else true))
    |> Seq.map (fun (order, nfa) -> proof_order return next s nfa order)
    |> Seq.find (function
      | Some _ -> true
      | None -> false)
    |> function
    | Some x -> x
    | None -> None
  ;;

  let combine_model_pieces s order (model, len) models =
    let vars = Map.keys s.vars |> List.filter_map Ir.var_val in
    trace_log
      "vars: [%a]"
      (Format.pp_print_list ~pp_sep:Format.pp_print_space Format.pp_print_string)
      vars;
    let rec helper mapVals len order past_order parts =
      let len_of_var = function
        | Ir.Var var -> Map.find_exn mapVals var |> Extra.nat_model_to_int |> logBaseZ
        | Ir.Pow2 var -> Map.find_exn mapVals var |> Extra.nat_model_to_int |> Z.to_int
      in
      match order with
      | [] -> Result.Ok mapVals
      | (Ir.Var _ as v) :: tl -> helper mapVals len tl (v :: past_order) parts
      | (Ir.Pow2 var as exp) :: tl ->
        (match parts with
         | [] ->
           failwith
             "Internal error occured: not enough model parts to construct full model"
         | part :: parts ->
           let prev_var =
             past_order
             |> List.find (function
               | Ir.Var var2 when var2 = var -> true
               | Ir.Pow2 _ -> true
               | _ -> false)
           in
           trace_log
             "inside combine_model_pieces: exp=%a, prev_var=%a"
             Ir.pp_atom
             exp
             Ir.pp_atom
             prev_var;
           (try
              let path_len = len_of_var exp - len_of_var prev_var in
              if path_len > Config.huge_path ()
              then
                (* let () = Format.eprintf "Calculated path_len = %d\n%!" path_len in *)
                Result.Error (mapVals |> Map.map_keys_exn ~f:Ir.var)
              else (
                let model2 = part path_len |> Option.get in
                let new_model, new_len =
                  NfaNat.combine_model_pieces
                    (List.map (Map.find_exn mapVals) vars, len)
                    model2
                in
                let mapVals = new_model |> Base.List.zip_exn vars |> Map.of_alist_exn in
                helper mapVals new_len tl (exp :: past_order) parts)
            with
            | _ -> Result.Error (mapVals |> Map.map_keys_exn ~f:Ir.var)))
    in
    let mapVals = Base.List.zip_exn vars model |> Map.of_alist_exn in
    helper mapVals len order [] models |> Result.map (Map.map_keys_exn ~f:Ir.var)
  ;;

  let get_model_nfa ir () =
    let nfa, vars = ir |> eval in
    let free_vars = ir |> Ir.collect_free_atoms |> Set.to_list in
    Nfa.any_path nfa (List.map (fun v -> Map.find_exn vars v) free_vars)
    |> Option.map (fun (model, _) ->
      List.mapi (fun i v -> List.nth free_vars i, v) model |> Map.of_alist_exn)
  ;;

  let get_model_semenov f s order (model, len) models () =
    let get_val map atom = Extra.nat_model_to_int (Map.find_exn map atom) in
    let apply ?(light = false) map ir =
      trace_log "Formula before substitutions: %a" Ir.pp f;
      trace_log
        "Variable map: %a"
        (Format.pp_print_list
           ~pp_sep:(fun fmt () -> Format.fprintf fmt "\n")
           (fun fmt (a, b) ->
              Format.fprintf
                fmt
                "%a -> %a\n"
                Ir.pp_atom
                a
                Z.pp_print
                (Extra.nat_model_to_int b)))
        (Map.to_alist map);
      let filter =
        let decide cond atom =
          if Map.mem map atom
          then (
            match cond atom with
            | true -> true
            | false -> if light then false else raise Too_long_model)
          else false
        in
        let good v =
          Z.fits_int (get_val map v) && Z.(get_val map v <= of_int (Config.huge_path ()))
        in
        let free_atoms = Ir.collect_free_atoms ir in
        fun k ->
          match k with
          | Ir.Pow2 _ -> decide good (get_exp k)
          | Ir.Var _ ->
            if light
            then Map.mem map k
            else decide (fun x -> (not (Set.mem free_atoms (to_exp x))) || good x) k
      in
      let f =
        f
        |> Ir.map (function
          | Ir.Rel (rel, term, c) ->
            let c =
              term
              |> Map.filter_keys ~f:filter
              |> Map.to_sequence
              |> Base.Sequence.map ~f:(fun (k, v) ->
                Z.mul
                  v
                  (match k with
                   | Ir.Pow2 x -> pow2z (get_val map (Var x))
                   | Ir.Var _ -> get_val map k))
              |> Base.Sequence.fold ~init:c ~f:Z.( - )
            in
            let term = term |> Map.filter_keys ~f:(Fun.negate filter) in
            Ir.rel rel term c
          | SReg (atom, re) when Map.mem map atom -> Ir.true_
          | SRegRaw (atom, re) when Map.mem map atom -> Ir.true_
          | SLen (atom, atom') when is_exp atom' && filter atom' ->
            let new_atom = Ir.internal () in
            let v = get_val map (get_exp atom') in
            Ir.land_
              [ Ir.slen atom new_atom; Ir.eq (Map.singleton new_atom Z.one) (pow2z v) ]
          | SLen (atom, atom') when (not (is_exp atom)) && filter atom ->
            let new_atom = Ir.internal () in
            let v = get_val map atom in
            Ir.land_ [ Ir.slen new_atom atom'; Ir.eq (Map.singleton new_atom Z.one) v ]
          | SLen (atom, atom') when (not (is_exp atom')) && filter atom' ->
            let new_atom = Ir.internal () in
            let v = get_val map atom' in
            Ir.land_ [ Ir.slen atom new_atom; Ir.eq (Map.singleton new_atom Z.one) v ]
          | x -> x)
      in
      trace_log "Formula after substituting exponents: %a\n" Ir.pp f;
      let result = f |> Ir.simpl |> Ir.simpl_ineq in
      trace_log "Formula after simplifications: %a" Ir.pp f;
      result
    in
    let get_model_simpl map ir =
      let model_vars = Ir.collect_model_vars ir |> Map.keys in
      let map_true_model_vars =
        map
        |> Map.keys
        |> List.filter (fun x -> not (Base.String.is_prefix (Ir.name x) ~prefix:"%"))
      in
      let signed_map = Map.map ~f:Extra.nat_model_to_model map in
      if List.equal Ir.eq_atom model_vars map_true_model_vars
      then Some signed_map
      else (
        let ir_map = apply ~light:true signed_map ir in
        let partial_model = Ir.get_partial_model ir_map in
        match List.equal Ir.eq_atom model_vars (partial_model |> List.map fst) with
        | true ->
          Some
            (partial_model
             |> List.map (fun (var, n) -> var, Extra.int_to_model n)
             |> Map.of_alist_exn)
        | false -> None)
    in
    match combine_model_pieces s (List.rev order) (model, len) models with
    | Result.Error map ->
      (match get_model_simpl map f with
       | Some m -> Result.Ok m
       | None -> Result.Error `Too_long)
    | Result.Ok map ->
      (match get_model_simpl map f with
       | Some m -> Result.Ok m
       | None ->
         (try
            let f = apply map f in
            let model = get_model_nfa f () |> Option.get in
            Result.Ok
              (Map.merge map model ~f:(fun ~key -> function
                 | `Left x -> Some x
                 | `Right x -> Some x
                 | `Both (x, y) ->
                   failwith
                     (Format.asprintf
                        "Should be unreachable, two models for %a: %a %a"
                        Ir.pp_atom
                        key
                        Z.pp_print
                        (Extra.nat_model_to_int x)
                        Z.pp_print
                        (Extra.nat_model_to_int y))))
          with
          | Too_long_model -> Result.Error `Too_long))
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
    let run_semenov = Ir.collect_vars ir |> Map.keys |> List.exists is_exp in
    if run_semenov
    then
      if Config.config.no_model
      then
        ir
        |> eval_semenov
             (fun _ _ nfa _ -> if NfaNat.run nfa then Some () else None)
             (fun var nfa -> NfaNat.project [ var ] nfa)
        |> function
        | Some _ -> sat_if_no_unsupp (fun () -> Result.error `No_model)
        | None -> `Unsat
      else (
        let res =
          ir
          |> eval_semenov
               (fun s order nfa model ->
                  match
                    NfaNat.any_path
                      nfa
                      (s.vars |> Map.filter_keys ~f:Ir.is_var |> Map.data)
                  with
                  | Some path -> Some (s, order, path, model)
                  | None -> None)
               (fun _ nfa -> nfa)
        in
        begin match res with
        | None -> if !Config.bounded_unsat then `Unknown else `Unsat
        | Some (s, order, (model, len), models) ->
          sat_if_no_unsupp (get_model_semenov ir s order (model, len) models)
        (* (match get_model_semenov ir s order (model, len) models with
             | `Cant_get_model -> `Sat (Result.Error `Too_long)
             | `Ok x -> `Sat (Result.Ok x)) *)
        end)
    else (
      let free_vars = Ir.collect_free ir in
      let ir' = Ir.exists (free_vars |> Set.to_list) ir in
      Debug.trace "LICS" "Trying to use automatic decision procedure over %a\n" Ir.pp ir;
      if Config.config.no_model
      then
        begin if ir' |> eval |> fst |> Nfa.run
        then sat_if_no_unsupp (fun () -> Result.Ok Map.empty)
        else `Unsat
        end
      else (
        let model = get_model_nfa ir () in
        match model with
        | Some model -> sat_if_no_unsupp (fun () -> Result.Ok model)
        | None -> `Unsat))
  ;;
end

(*module LsbStr (B : Nfa.Base) =
  Make
    (Nfa.Lsb (Nfa.Str (B))) (NfaCollection.LsbStr (B)) (Nfa.Lsb (Nfa.Str (B)))
    (NfaCollection.LsbStr (B))
    (struct
      module Str = Nfa.Str (B)
      module Nfa = Nfa.Lsb (Nfa.Str (B))

      let eval_reg _vars _reg _atoms = failwith "not implemented for string theory"

      let eval_sreg vars atom reg =
        let nfa = reg |> NfaO.String.of_regex in
        Debug.dump_nfa ~msg:"SREG %s" ~vars:(Map.to_alist vars) NfaO.String.format_nfa nfa;
        (*let reenum = Map.singleton (Map.find_exn vars atom) 0 in*)
        let reenum = Map.singleton (Map.find_exn vars atom) 0 in
        NfaO.String.reenumerate reenum nfa
      ;;

      let eval_sregraw vars atom reg =
        let nfa = reg in
        let reenum = Map.singleton (Map.find_exn vars atom) 0 in
        Nfa.reenumerate reenum nfa
      ;;

      let model_to_int c =
        c
        |> List.to_seq
        |> Seq.filter (( <> ) Str.u_eos)
        |> Seq.filter (( <> ) Str.u_null)
        |> List.of_seq
        |> List.rev
        |> Base.List.drop_while ~f:(( = ) Str.u_zero)
        |> Base.String.of_list
        |> fun s -> if String.length s = 0 then Z.zero else Z.of_string s
      ;;

      let nat_model_to_int = model_to_int
      let nat_model_to_model = Fun.id
      let char_to_v c = c

      let int_to_model n =
        n |> Z.to_string |> String.to_seq |> List.of_seq |> List.rev |> List.map char_to_v
      ;;
    end)

module LsbStrBv =
  Make (Nfa.Lsb (Nfa.StrBv)) (NfaCollection.LsbStrBv) (Nfa.Lsb (Nfa.StrBv))
    (NfaCollection.LsbStrBv)
    (struct
      module Str = Nfa.StrBv
      module Nfa = Nfa.Lsb (Nfa.StrBv)

      let eval_reg _vars _reg _atoms = failwith "not implemented for string theory"

      let eval_sreg vars atom reg =
        let nfa = reg |> NfaO.String.of_regex in
        let nfa = nfa |> NfaO.convert_nfa_lsb in
        Debug.dump_nfa ~msg:"SREG %s" ~vars:(Map.to_alist vars) Nfa.format_nfa nfa;
        (*let reenum = Map.singleton (Map.find_exn vars atom) 0 in*)
        let reenum = Map.singleton (Map.find_exn vars atom) 0 in
        Nfa.reenumerate reenum nfa
      ;;

      let eval_sregraw vars atom reg =
        let nfa = reg |> NfaO.convert_nfa_lsb in
        let reenum = Map.singleton (Map.find_exn vars atom) 0 in
        Nfa.reenumerate reenum nfa
      ;;

      let model_to_int c =
        c
        |> List.to_seq
        |> Seq.filter (( <> ) Str.u_eos)
        |> Seq.filter (( <> ) Str.u_null)
        |> List.of_seq
        |> List.rev
        |> Base.List.drop_while ~f:(( = ) Str.u_zero)
        |> List.map strbv_to_char
        |> Base.String.of_list
        |> fun s -> if String.length s = 0 then Z.zero else Z.of_string s
      ;;

      let nat_model_to_int = model_to_int
      let char_to_v = char_to_strbv
      let nat_model_to_model = Fun.id

      let int_to_model n =
        n |> Z.to_string |> String.to_seq |> List.of_seq |> List.rev |> List.map char_to_v
      ;;
    end)*)

module MsbStrExtra (B : Nfa.Base) = struct
  module NfaO = Nfa
  module NfaO2 = Nfa.Msb (Str (B))
  module Nfa = Nfa.Msb (Str (B))
  module Str = NfaO.Str (B)

  let eval_reg _vars _reg _atoms = failwith "not implemented for string theory"
  let eval_sreg vars atom reg = failwith ""

  let eval_sregraw : (Ir.atom, int) Map.t -> Ir.atom -> NfaO.String.u -> Nfa.t =
    fun _ _ _ -> failwith ""
  ;;

  let nat_model_to_int =
    int_of_path (module NfaO.Str (B)) ~mode:`Msb z_of_char_list ?negate_symbol:Option.none
  ;;

  let char_to_v c = c
  let nat_model_to_model model = char_to_v '0' :: model

  let int_to_model n =
    n |> Z.to_string |> String.to_seq |> List.of_seq |> List.map char_to_v
  ;;
end

module MsbStr (B : Nfa.Base) =
  Make
    (Nfa.MsbNat (Nfa.Str (B))) (NfaCollection.MsbNatStr (B)) (Nfa.Msb (Nfa.Str (B)))
    (NfaCollection.MsbStr (B))
    (MsbStrExtra (B))

module MsbStr10 =
  Make
    (Nfa.MsbNat
       (Nfa.Str (Nfa.Base10))) (NfaCollection.MsbNatStr (Nfa.Base10))
       (Nfa.Msb (Nfa.Str (Nfa.Base10)))
    (NfaCollection.MsbStr (Nfa.Base10))
    (struct
      include MsbStrExtra (Nfa.Base10)
      module Convert = NfaO.ConvertStr (NfaO.Base10)

      let eval_sreg vars atom reg =
        let reg =
          Regex.concat
            (Regex.concat
               (Regex.kleene (Regex.symbol [ Str.u_eos ]))
               (Regex.symbol [ Str.u_eos ]))
            reg
        in
        let nfa = reg |> NfaO2.of_regex in
        let reenum = Map.singleton (Map.find_exn vars atom) 0 in
        Nfa.reenumerate reenum nfa
      ;;

      let eval_sregraw : (Ir.atom, int) Map.t -> Ir.atom -> NfaO.String.u -> Nfa.t =
        fun vars atom reg ->
        let nfa = NfaO2.of_lsb (Convert.str reg) in
        let reenum = Map.singleton (Map.find_exn vars atom) 0 in
        Nfa.reenumerate reenum nfa
      ;;
    end)

module MsbStrBvExtra (B : Nfa.Base) = struct
  module NfaO2 = Nfa.Msb (Nfa.Str (B))
  module Str = Nfa.StrBv (B)
  module Nfa = Nfa.Msb (Nfa.StrBv (B))
  module Convert = NfaO.ConvertStr (B)

  let eval_reg _vars _reg _atoms = failwith "not implemented for string theory"
  let eval_sreg vars atom reg = failwith ""

  let eval_sregraw : (Ir.atom, int) Map.t -> Ir.atom -> NfaO.String.u -> Nfa.t =
    fun _ _ _ -> failwith ""
  ;;

  let _model_to_int =
    int_of_path
      (module NfaO.StrBv (B))
      ~mode:`Msb
      z_of_strbv_list
      ~negate_symbol:strbv_negate
  ;;

  let nat_model_to_int =
    int_of_path
      (module NfaO.StrBv (B))
      ~mode:`Msb
      z_of_strbv_list
      ?negate_symbol:Option.none
  ;;

  let char_to_v = char_to_strbv
  let nat_model_to_model model = char_to_v '0' :: model

  let int_to_model n =
    n |> Z.to_string |> String.to_seq |> List.of_seq |> List.map char_to_v
  ;;
end

module MsbStrBv (B : Nfa.Base) =
  Make
    (Nfa.MsbNat (Nfa.StrBv (B))) (NfaCollection.MsbNatStrBv (B)) (Nfa.Msb (Nfa.StrBv (B)))
    (NfaCollection.MsbStrBv (B))
    (MsbStrBvExtra (B))

module MsbStrBv10 =
  Make
    (Nfa.MsbNat
       (Nfa.StrBv (Nfa.Base10))) (NfaCollection.MsbNatStrBv (Nfa.Base10))
       (Nfa.Msb (Nfa.StrBv (Nfa.Base10)))
    (NfaCollection.MsbStrBv (Nfa.Base10))
    (struct
      include MsbStrBvExtra (Nfa.Base10)
      module Convert = NfaO.ConvertStr (NfaO.Base10)

      let eval_sreg vars atom reg =
        let nfa = reg |> NfaO2.of_regex in
        let nfa = nfa |> Convert.msb in
        let reenum = Map.singleton (Map.find_exn vars atom) 0 in
        Nfa.reenumerate reenum nfa
      ;;

      let eval_sregraw : (Ir.atom, int) Map.t -> Ir.atom -> NfaO.String.u -> Nfa.t =
        fun vars atom reg ->
        let nfa = NfaO2.of_lsb (Convert.str reg) in
        let nfa = nfa |> Convert.msb in
        let reenum = Map.singleton (Map.find_exn vars atom) 0 in
        Nfa.reenumerate reenum nfa
      ;;
    end)

module Lsb =
  Make (Nfa.Lsb (Nfa.Bv)) (NfaCollection.Lsb) (Nfa.Lsb (Nfa.Bv)) (NfaCollection.Lsb)
    (struct
      module NfaO = Nfa
      module Nfa = Nfa.Lsb (Nfa.Bv)

      let eval_reg vars reg atoms =
        let nfa = reg |> Nfa.of_regex in
        let reenum =
          0 -- (List.length atoms - 1)
          |> Map.of_list_with_key_exn ~get_key:Fun.id
          |> Map.map_keys_exn ~f:(fun k -> Map.find_exn vars (List.nth atoms k))
        in
        Nfa.reenumerate reenum nfa
      ;;

      let eval_sreg _vars _atom _regex =
        failwith "string constraints are not supported in EIA mode"
      ;;

      let eval_sregraw _vars _atom _regex =
        failwith "string constraints are not supported in EIA mode"
      ;;

      let nat_model_to_int =
        int_of_path (module NfaO.Bv) ~mode:`Lsb z_of_bool_list ?negate_symbol:Option.none
      ;;

      let nat_model_to_model = Fun.id

      (*let char_to_v c =
        match c with
        | '0' -> false
        | '1' -> true
        | _ -> failwith "string constraints are not supported in EIA mode"
      ;;*)

      let int_to_model n = n |> Utils.to_bits
    end)

module Msb =
  Make (Nfa.MsbNat (Nfa.Bv)) (NfaCollection.MsbNat) (Nfa.Msb (Nfa.Bv)) (NfaCollection.Msb)
    (struct
      module NfaO = Nfa
      module Nfa = Nfa.Msb (Nfa.Bv)

      let eval_reg vars reg atoms =
        let nfa = reg |> Nfa.of_regex in
        let reenum =
          0 -- (List.length atoms - 1)
          |> Map.of_list_with_key_exn ~get_key:Fun.id
          |> Map.map_keys_exn ~f:(fun k -> Map.find_exn vars (List.nth atoms k))
        in
        Nfa.reenumerate reenum nfa
      ;;

      let eval_sreg _vars _atom _regex =
        failwith "string constraints are not supported in EIA mode"
      ;;

      let eval_sregraw _vars _atom _regex =
        failwith "string constraints are not supported in EIA mode"
      ;;

      let nat_model_to_int =
        int_of_path (module NfaO.Bv) ~mode:`Msb z_of_bool_list ?negate_symbol:Option.none
      ;;

      let char_to_v c =
        match c with
        | '0' -> false
        | '1' -> true
        | _ -> failwith "string constraints are not supported in EIA mode"
      ;;

      let nat_model_to_model model = char_to_v '0' :: model
      let int_to_model n = n |> Utils.to_bits |> Base.List.rev |> fun x -> false :: x
    end)

let is_internal = String.starts_with ~prefix:"%"
let ( let* ) = Result.bind
let return = Result.ok

let check_sat ir
  : [ `Sat of Model.tys -> (Model.t, [ `Too_long | `No_model ]) Result.t
    | `Unsat
    | `Unknown of Ir.t
    ]
  =
  let logBaseZ n =
    let base = !Config.base |> Z.of_int in
    let rec helper acc n =
      if n = Z.zero then acc else helper Z.(acc + one) Z.(n / base)
    in
    helper Z.minus_one n
  in
  let flatten_pows_in_model model =
    Map.mapi
      ~f:(fun ~key ~data ->
        match data with
        | `Str str -> `Str str
        | `Int eia ->
          begin match key with
          | Ir.Var _ -> data
          | Pow2 _ -> `Int (logBaseZ eia)
          end)
      model
    |> Map.map_keys_exn ~f:(function
      | Ir.Var v -> v
      | Ir.Pow2 _ -> assert false)
  in
  let on_no_strings ir =
    let checker =
      match Config.config.mode with
      | `Lsb -> Lsb.check_sat
      | `Msb -> Msb.check_sat
    in
    match checker ir with
    | `Sat model ->
      (match model () with
       | Result.Error `Too_long ->
         let f tys = Result.Error `Too_long in
         `Sat f
       | Result.Error `No_model ->
         let f tys = Result.Error `No_model in
         `Sat f
       | Result.Ok model ->
         let f tys =
           Result.Ok
             (model
              |> Map.mapi ~f:(fun ~key:k ~data:v ->
                let k' =
                  match k with
                  | Ir.Var k -> k
                  | Pow2 _ -> ""
                in
                match Map.find tys k' with
                | None | Some `Int ->
                  let v = int_of_path (module Nfa.Bv) z_of_bool_list v in
                  let v =
                    match k with
                    | Ir.Var _ -> v
                    | Pow2 _ ->
                      let logBase =
                        match Config.config.mode with
                        | `Lsb -> Lsb.logBaseZ
                        | `Msb -> Msb.logBaseZ
                      in
                      logBase v |> Z.of_int
                  in
                  `Int v
                | Some `Str ->
                  failwith "there is something strange: there is string variable in EIA")
              |> Map.map_keys_exn ~f:(function
                | Ir.Pow2 atom -> atom
                | Ir.Var atom -> atom) (*|> filter_internal*))
         in
         `Sat f)
    | `Unsat -> `Unsat
    | `Unknown -> `Unknown ir
  in
  let on_strings ir =
    let checker =
      let wrap f =
        fun ir ->
        match f ir with
        | `Sat model ->
          `Sat
            (fun () ->
              let* model = model () in
              let model = Map.map ~f:(List.map strbv_to_char) model in
              return model)
        | `Unknown -> `Unknown
        | `Unsat -> `Unsat
      in
      let module B = struct
        let base = Z.of_int !Config.base
      end
      in
      match Config.config.logic, Config.config.mode with
      | `Str, `Lsb ->
        trace_log "Running string LSB mode";
        failwith "LSB mode is temporarily disabled"
      | `Str, `Msb ->
        trace_log "Running string MSB mode";
        if !Config.base = 10
        then MsbStr10.check_sat
        else
          let module MsbStr = MsbStr (B) in
          MsbStr.check_sat
      | `StrBv, `Lsb ->
        trace_log "Running string-bitvector LSB mode";
        failwith "LSB mode is temporarily disabled"
      | `StrBv, `Msb ->
        trace_log "Running string-bitvector MSB mode";
        if !Config.base = 10
        then wrap MsbStrBv10.check_sat
        else
          let module MsbStrBv = MsbStrBv (B) in
          wrap MsbStrBv.check_sat
      | _ -> assert false
    in
    match checker ir with
    | `Sat model ->
      `Sat
        (fun tys ->
          let module B = struct
            let base = Z.of_int !Config.base
          end
          in
          let* model = model () in
          let model =
            Map.mapi
              ~f:(fun ~key:k ~data:v ->
                let ty =
                  match k with
                  | Ir.Var k -> Map.find tys k |> Option.value ~default:`Int
                  | _ -> `Int
                in
                match ty with
                | `Int ->
                  begin try
                    `Int
                      (int_of_path
                         (module Nfa.Str (B))
                         z_of_char_list
                         ~negate_symbol:char_negate
                         v)
                    (*let s = v |> z_of_list_str in
                    if String.length s > 0 then `Int (Z.of_string s) else `Int Z.zero*)
                  with
                  | Invalid_argument ex as exp ->
                    Format.printf "Something is wrong: %s\n%!" (Printexc.to_string exp);
                    `Str (v |> string_of_path (module Nfa.Str (B)) string_of_char_list)
                  end
                | `Str ->
                  `Str (v |> string_of_path (module Nfa.Str (B)) string_of_char_list))
              model
          in
          let model = flatten_pows_in_model model in
          return model)
    | `Unsat -> `Unsat
    | `Unknown -> `Unknown ir
  in
  match Config.config.logic with
  | `Eia -> on_no_strings ir
  | `Str | `StrBv -> on_strings ir
;;
