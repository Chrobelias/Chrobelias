(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Set = Base.Set.Poly
module Map = Base.Map.Poly

type t =
  { vars : (Ir.atom, int) Map.t
  ; internal_counter : int
  }

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
(*let ir_atom_to_eia_term : Ir.atom -> Ast.Eia.term = function
  | Ir.Var s -> Ast.Eia.atom (Ast.var s)
  | Ir.Pow2 s ->
    Ast.Eia.pow (Ast.Eia.atom (Ast.const (Config.base ()))) (Ast.Eia.atom (Ast.var s))
;;

let ir_atom_to_str_term : Ir.atom -> Ast.Str.term = function
  | Ir.Var s -> Ast.Eia.atom (Ast.var s)
  | Ir.Pow2 _ -> failwith "only vars are supported inside string IRs"
;;

let ir_atom_to_atom : Ir.atom -> Ast.atom = function
  | Ir.Var s -> Ast.var s
  | Ir.Pow2 _ -> failwith "only vars are supported to be converted back in AST"
;;

let rec ir_to_ast : Ir.t -> Ast.t = function
  | True -> Ast.true_
  | Lnot lhs -> Ast.lnot (ir_to_ast lhs)
  | Land ls -> Ast.land_ (List.map ir_to_ast ls)
  | Lor ls -> Ast.lor_ (List.map ir_to_ast ls)
  | Reg (_, _) -> failwith "TBD"
  | Rel (rel, poly, c) ->
    let build =
      match rel with
      | Ir.Leq -> Ast.Eia.leq
      | Ir.Eq -> Ast.Eia.eq
    in
    let poly =
      Map.fold
        ~f:(fun ~key ~data acc ->
          Ast.Eia.mul [ Ast.Eia.atom (Ast.const data); ir_atom_to_eia_term key ] :: acc)
        ~init:[]
        poly
    in
    let lhs = Ast.Eia.add poly in
    let rhs = Ast.Eia.atom (Ast.const c) in
    Ast.eia (build lhs rhs)
  | SReg (atom, re) -> Ast.str (Ast.Str.inre (ir_atom_to_str_term atom) re)
  | SEq (atom, atom') ->
    Ast.eia (Ast.Eia.eq (ir_atom_to_str_term atom) (ir_atom_to_str_term atom'))
  | SPrefixOf (atom, atom') ->
    Ast.str (Ast.Str.prefixof (ir_atom_to_str_term atom) (ir_atom_to_str_term atom'))
  | SContains (atom, atom') ->
    Ast.str (Ast.Str.contains (ir_atom_to_str_term atom) (ir_atom_to_str_term atom'))
  | SSuffixOf (atom, atom') ->
    Ast.str (Ast.Str.suffixof (ir_atom_to_str_term atom) (ir_atom_to_str_term atom'))
  | SLen (atom, atom') ->
    Ast.eia
      (Ast.Eia.eq
         (Ast.Eia.atom (ir_atom_to_atom atom))
         (Ast.Eia.len2 (ir_atom_to_atom atom')))
  | Stoi (atom, atom') ->
    Ast.eia
      (Ast.Eia.eq
         (Ast.Eia.atom (ir_atom_to_atom atom))
         (Ast.Eia.iofs (Ast.Eia.atom (ir_atom_to_atom atom'))))
  | Itos (atom, atom') ->
    Ast.eia
      (Ast.Eia.eq
         (Ast.Eia.atom (ir_atom_to_atom atom))
         (Ast.Eia.iofs (Ast.Eia.atom (ir_atom_to_atom atom'))))
  | Exists ([], lhs) -> ir_to_ast lhs
  | Exists (atoms, lhs) -> Ast.exists (List.map ir_atom_to_atom atoms) (ir_to_ast lhs)
;;*)

let ( -- ) i j =
  let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
  aux j []
;;

let do_if_msb f = if Config.config.mode = `Msb then f else Fun.id
let do_if_lsb f = if Config.config.mode = `Lsb then f else Fun.id

(*type bound =
       | EqConst of Ir.atom * int
  | LeqConst of (Ir.atom, int) Map.t * int
  | EqVar of Ir.atom * Ir.atom
*)

(* let antiprenex ir =
  (*let rec infer_bounds : Ir.t -> _ = function
                | Ir.Land irs ->
                                let bounds = List.map infer_bounds irs in
Set.union_list bounds
       | Ir.Lor irs ->
                       let bounds = List.map infer_bounds irs in
begin
        match bounds with
        | hd :: tl -> List.fold_left Set.inter hd tl
        | _ -> Set.empty
      end
       | True -> Set.empty
    | Rel (Ir.Leq, term, c) -> Set.singleton (LeqConst (term, c))
    | Rel (Ir.Eq, term, c) when Map.length term = 1 ->
                    let k, v = Map.nth_exn term 0 in
if v = 1
      then (
              let bound = EqConst (k, c) in
Set.singleton bound)
        else if v = -1
      then (
              let bound = EqConst (k, -c) in
Set.singleton bound)
      else Set.empty
       | Rel (Ir.Eq, term, 0)
      when Map.length term = 2
           && Map.nth_exn term 0 |> snd = -1
           && Map.nth_exn term 1 |> snd = 1
           && Map.for_alli
                ~f:(fun ~key ~data:_ ->
                        match key with
                  | Ir.Var _ -> true
                  | Ir.Pow2 _ -> false)
                term (* TODO: without the last assert it breaks get_model_semenov *) ->
                        let v1 = Map.nth_exn term 0 |> fst in
let v2 = Map.nth_exn term 1 |> fst in
Set.singleton (EqVar (v1, v2))
       | Rel (Ir.Eq, term, 0)
      when Map.length term = 2
           && Map.nth_exn term 0 |> snd = 1
           && Map.nth_exn term 1 |> snd = -1
           && Map.for_alli
                ~f:(fun ~key ~data:_ ->
                        match key with
                  | Ir.Var _ -> true
                  | Ir.Pow2 _ -> false)
                term (* TODO: without the last assert it breaks get_model_semenov *) ->
                        let v1 = Map.nth_exn term 0 |> fst in
let v2 = Map.nth_exn term 1 |> fst in
Set.singleton (EqVar (v1, v2))
       | Ir.Exists (atoms, ir) ->
                       let atoms' = Set.of_list atoms in
let bounds = infer_bounds ir in
Set.filter
        ~f:(function
                | EqConst (atom, _) -> Set.mem atoms' atom |> not
          | EqVar (atom, _) -> Set.mem atoms' atom |> not
          | LeqConst (term, _) ->
                          Set.inter atoms' (Map.keys term |> Set.of_list) |> Set.is_empty)
        bounds
       | _ -> Set.empty
in
  let apply_bounds bounds ir =
          Ir.map
      (function
              | Ir.Rel (rel, term, c) -> begin
                      let atoms = Map.keys term in
                      let bounded_atoms =
                              List.filter_map
              (fun atom ->
                      let atom_bound =
                              Set.find
                     ~f:(fun bound ->
                             match bound with
                       | EqConst (atom', _) when atom = atom' -> true
                       | _ -> false)
                     bounds
                      in
                 begin
                         match atom_bound with
                   | Some (EqConst (atom, c)) -> Some (atom, c)
                   | _ -> None
                 end)
              atoms
                   |> Map.of_alist_exn
                      in
          let eq_atoms =
                  List.filter_map
              (fun atom ->
                      let atom_bound =
                              Set.find
                     ~f:(fun bound ->
                             match bound with
                       | EqVar (atom', _) when atom = atom' -> true
                       | _ -> false)
                     bounds
                      in
                 begin
                         match atom_bound with
                   | Some (EqVar (atom, atom')) -> Some (atom, atom')
                   | _ -> None
                 end)
              atoms
                   |> Map.of_alist_exn
                      in
          let build =
                  match rel with
            | Ir.Eq -> Ir.eq
            | Ir.Leq -> Ir.leq
          in
          let c =
                  Map.to_alist term
            |> List.fold_left
                 (fun acc (atom, a) ->
                         match Map.find bounded_atoms atom with
                    | Some c' -> acc - (c' * a)
                    | None -> acc)
                 c
          in
          let term =
                  Map.filter_keys ~f:(fun atom -> Map.mem bounded_atoms atom |> not) term
          in
          let term =
                  term
                    |> Map.to_alist
            |> List.map (fun (atom, c) ->
                            match Map.find eq_atoms atom with
              | Some atom' -> atom', c
              | None -> atom, c)
            |> Map.of_alist_fold ~f:( + ) ~init:0
          in
          build term c
                 end
              | ir -> ir)
      ir
              |> Ir.map (function
                      | Ir.Rel (Ir.Leq, term, c) as ir ->
                                      let c' =
                                              Set.filter_map
            ~f:(fun bound ->
                    match bound with
              | LeqConst (term', c') when Map.equal ( = ) term term' -> Some c'
              | _ -> None)
            bounds
              |> Set.fold ~f:Int.min ~init:Int.max_int
          in
        if c' < c then Ir.true_ else ir
              | ir -> ir)
                                      in*)
  (*let aux ir =
          Ir.map
      (function
              | Ir.Exists (atoms, ir') ->
                              let atoms' = Set.of_list atoms in
let bounds = infer_bounds ir' in
let bounds' =
        Set.filter
              ~f:(function
                      | EqConst (atom, _) -> Set.mem atoms' atom
                | EqVar (atom, _) -> Set.mem atoms' atom
                | LeqConst (term, _) ->
                                Set.inter atoms' (Map.keys term |> Set.of_list) |> Set.is_empty |> not)
              bounds
in
          Ir.exists atoms (apply_bounds bounds' ir' |> simpl)
          | ir -> ir)
      ir
in*)
  let rec aux2 ir =
    let ir' = (*aux *) ir |> Ir.simpl |> Ir.antiprenex in
    if Ir.equal ir ir' then ir' else aux2 ir'
  in
  aux2 ir
;; *)

open Config

let level = ref 0

module NfaS = Nfa.Lsb (Nfa.Str)
module Str = Nfa.Str

module Make
    (NfaNat : Nfa.NatType)
    (NfaCollectionNat : NfaCollection.NatType with type t = NfaNat.t)
    (Nfa : Nfa.Type with type u = NfaNat.t and type v = NfaNat.v)
    (NfaCollection : NfaCollection.Type with type t = Nfa.t)
    (Extra : sig
       val eval_sreg : (Ir.atom, int) Map.t -> Ir.atom -> char list Regex.t -> Nfa.t
       val eval_sregraw : (Ir.atom, int) Map.t -> Ir.atom -> NfaS.t -> Nfa.t
       val eval_reg : (Ir.atom, int) Map.t -> bool list Regex.t -> Ir.atom list -> Nfa.t
       val model_to_int : Nfa.v list -> Z.t
       val nat_model_to_int : NfaNat.v list -> Z.t
       val char_to_v : char -> NfaCollection.v
     end) =
struct
  let is_exp = Ir.is_exp

  let collect_alpha (ir : Ir.t) =
    if Config.config.logic = `Eia
    then None
    else (
      let ( let* ) = Option.bind in
      let return = Option.some in
      let* alpha =
        Ir.fold
          (fun acc -> function
             | Ir.SReg (_, re) ->
               let* acc = acc in
               Regex.symbols re |> List.flatten |> Set.of_list |> Set.union acc |> return
             | Ir.SRegRaw (_, nfa) ->
               let* acc = acc in
               Ir.NfaS.alpha nfa |> Set.union acc |> return
             | Ir.Lnot _ -> Option.none
             | _ ->
               let* acc = acc in
               return acc)
          (Some Set.empty)
          ir
      in
      let alpha =
        Set.diff alpha (Set.of_list [ Str.u_eos; Str.u_null ])
        |> Set.map ~f:Extra.char_to_v
      in
      return
        (if Set.is_empty alpha
         then
           Set.of_list
             (Str.alphabet
              |> List.take (Config.base () |> Z.to_int)
              |> List.map Extra.char_to_v)
         else alpha))
  ;;

  let eval ir =
    let ir = Ir.antiprenex ir in
    let alpha = collect_alpha ir |> Option.map Set.to_list in
    (*let ir = if Config.v.logic = `Eia then trivial ir else ir in*)
    let vars = Ir.collect_vars ir in
    (* Printf.printf "%s %d\n%!" __FILE__ __LINE__; *)
    if Config.config.dump_simpl then Format.printf "%a\n%!" Ir.pp_smtlib2 ir;
    if Config.config.stop_after = `Simpl then exit 0;
    let rec eval ir =
      if Config.config.dump_ir
      then Format.printf "%d Running %a\n%!" !level Ir.pp_smtlib2 ir;
      level := !level + 1;
      (match ir with
       | Ir.True -> NfaCollection.n ()
       | Ir.Lnot ir -> eval ir |> Nfa.invert
       (*
          | Ir.Land (hd :: tl) ->
                       List.fold_left (fun nfa ir -> eval ir |> Nfa.intersect nfa) (eval hd) tl
       *)
       | Ir.Land irs ->
         let nfas =
           List.map
             (fun ir ->
                let nfa = eval ir in
                Debug.printf "Nfa for %a has %d nodes\n%!" Ir.pp ir (Nfa.length nfa);
                nfa |> do_if_lsb Nfa.reverse, ir)
             irs
           |> List.sort (fun (nfa1, _) (nfa2, _) -> Nfa.length nfa1 - Nfa.length nfa2)
         in
         let rec eval_and = function
           | (hd, _) :: [] -> hd
           | (hd, ir) :: (hd', ir') :: tl ->
             Debug.printf
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
         Debug.printf "Intersect result %d \n%!" (Nfa.length nfa);
         nfa |> do_if_lsb Nfa.reverse
       | Ir.Lor (hd :: tl) ->
         List.fold_left (fun nfa ir -> eval ir |> Nfa.unite nfa) (eval hd) tl
       | Ir.Lor [] -> NfaCollection.z ()
       | Ir.Rel (rel, term, c) -> begin
         match rel with
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
         Debug.printf "(c, d)\n%!";
         Seq.iter
           (fun (c, d) -> Debug.printf "(%d, %d)\n%!" c d)
           (NfaNat.chrobak (nfa |> Nfa.to_nat));
         nfa
       | Ir.SRegRaw (atom, reg) -> Extra.eval_sregraw vars atom reg
       | Ir.SLen (atom, atom') ->
         NfaCollection.strlen
           ~alpha
           ~dest:(Map.find_exn vars atom')
           ~src:(Map.find_exn vars atom)
           ()
       | Ir.Stoi (atom, atom') ->
         NfaCollection.n ()
         (*NfaCollection.stoi ~dest:(Map.find_exn vars atom) ~src:(Map.find_exn vars atom')*)
       | Ir.SEq (atom, atom') ->
         NfaCollection.seq
           ~alpha
           ~dest:(Map.find_exn vars atom)
           ~src:(Map.find_exn vars atom')
           ()
       | _ -> failwith "unimplemented")
      |> fun nfa ->
      Debug.printfln "Done %a\n%!" Ir.pp ir;
      Debug.dump_nfa ~msg:"Evaluated %s" ~vars:(Map.to_alist vars) Nfa.format_nfa nfa;
      level := !level - 1;
      nfa
    in
    let nfa = eval ir in
    (*let nfa = apply_post_strings ( Ir.collect_free ir |> Set.to_list in*)
    nfa, vars
  ;;

  let logBase n =
    let rec helper acc = function
      | 0 -> acc
      | n -> helper (acc + 1) (n / Z.to_int NfaCollection.base)
    in
    helper (-1) n
  ;;

  let logBaseZ n =
    let base = NfaCollection.base in
    let rec helper acc n = if n = Z.zero then acc else helper (acc + 1) Z.(n / base) in
    helper (-1) n
  ;;

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
    Debug.printf
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
        Debug.printf
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
        Debug.printf
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
          Debug.printf "nfa_for_exponent: a=%d, a'=%d, c=%d\n%!" a a' c;
          Debug.dump_nfa
            ~msg:"nfa_for_exponent output nfa: %s"
            Nfa.format_nfa
            nfa
            ~vars:[ var, get_deg var ];
          nfa)
      else
        0 -- (c - 1)
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
          Debug.printf "nfa_for_exponent: a=%d, d=%d, c=%d, n=%d\n%!" a d c n;
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
    Debug.printfln
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
              Debug.printf "We are trying zeros for %a\n%!" Ir.pp_atom x';
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
    Debug.printf
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
        (*let* () =
          match Overapprox.check (ir_to_ast (Ir.land_ [ ir; order_ir ])) with
          | `Unknown ast -> Some ()
          | `Unsat -> None
          | _ -> Some ()
        in*)
        let order_nfa, order_vars = eval order_ir in
        Debug.dump_nfa ~msg:"Nfa order1: %s" Nfa.format_nfa order_nfa;
        order_vars
        |> Map.map_keys_exn ~f:(fun k -> Map.find_exn s.vars k)
        |> Map.iteri ~f:(fun ~key ~data -> Debug.printfln "   %d -> %d" key data);
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
    (*|> Seq.filter (function order, nfa ->
        let exp_vars = powered_vars |> Map.keys |> List.filter (fun x -> is_exp x) in
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
                        [ x, Z.minus_one; get_exp x, Z.of_int (NfaCollection.base - 1) ]
                    in
                    Nfa.to_nat (NfaCollection.leq powered_vars over_x Z.minus_one)))
          in
          Debug.dump_nfa
            ~msg:"Overapproxed nfa: %s"
            ~vars:(Map.to_alist vars)
            NfaNat.format_nfa
            nfa_with_over;
          let nfa_to_check =
            nfa_with_over
            |> NfaNat.project (order |> List.map (fun str -> Map.find_exn s.vars str))
          in
          Debug.dump_nfa ~msg:"Checking if solvable: %s" NfaNat.format_nfa nfa_to_check;
          nfa_to_check |> NfaNat.run)
        else true)*)
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
    Debug.printfln
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
           Debug.printfln
             "inside combine_model_pieces: exp=%a, prev_var=%a"
             Ir.pp_atom
             exp
             Ir.pp_atom
             prev_var;
           let path_len = len_of_var exp - len_of_var prev_var in
           if path_len > Config.max_longest_path
           then
             (* let () = Format.eprintf "Calculated path_len = %d\n%!" path_len in *)
             Result.Error `Too_long
           else (
             let model2 = part path_len |> Option.get in
             let new_model, new_len =
               NfaNat.combine_model_pieces
                 (List.map (Map.find_exn mapVals) vars, len)
                 model2
             in
             let mapVals = new_model |> Base.List.zip_exn vars |> Map.of_alist_exn in
             helper mapVals new_len tl (exp :: past_order) parts))
    in
    let mapVals = Base.List.zip_exn vars model |> Map.of_alist_exn in
    helper mapVals len order [] models |> Result.map (Map.map_keys_exn ~f:Ir.var)
  ;;

  let get_model_normal ir () =
    let nfa, vars = ir |> eval in
    let free_vars = ir |> Ir.collect_free_atoms |> Set.to_list in
    let model, _ =
      Nfa.any_path nfa (List.map (fun v -> Map.find_exn vars v) free_vars) |> Option.get
    in
    model |> List.mapi (fun i v -> List.nth free_vars i, v) |> Map.of_alist_exn
  ;;

  exception Too_long_model

  let get_model_semenov_exn f s order (model, len) models () =
    match combine_model_pieces s (List.rev order) (model, len) models with
    | Result.Error `Too_long -> raise Too_long_model
    | Result.Ok map ->
      Debug.printfln "Formula before substituting exponents: %a" Ir.pp f;
      Debug.printfln
        "Variable map: %a"
        (Format.pp_print_list
           ~pp_sep:(fun fmt () -> Format.fprintf fmt "\n")
           (fun fmt (a, b) ->
              Format.fprintf fmt "%a -> %a" Ir.pp_atom a Z.pp_print (Extra.model_to_int b)))
        (Map.to_alist map);
      let filter =
        fun k ->
        match k with
        | Ir.Pow2 _ -> Map.mem map (get_exp k)
        | Ir.Var _ -> Map.mem map k
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
                   | Ir.Pow2 x -> pow2z (Extra.model_to_int (Map.find_exn map (Var x)))
                   | Ir.Var _ -> Extra.model_to_int (Map.find_exn map k)))
              |> Base.Sequence.fold ~init:c ~f:Z.( - )
            in
            let term = term |> Map.filter_keys ~f:(Fun.negate filter) in
            Ir.rel rel term c
          | SReg (atom, re) when Map.mem map atom -> Ir.true_
          | SRegRaw (atom, re) when Map.mem map atom -> Ir.true_
          | SLen (atom, atom') when is_exp atom' && Map.mem map (get_exp atom') ->
            let new_atom = Ir.internal () in
            let v = Extra.model_to_int (Map.find_exn map (get_exp atom')) in
            Ir.land_
              [ Ir.slen atom new_atom; Ir.eq (Map.singleton new_atom Z.one) (pow2z v) ]
          | SLen (atom, atom') when (not (is_exp atom)) && Map.mem map atom ->
            let new_atom = Ir.internal () in
            let v = Extra.model_to_int (Map.find_exn map atom) in
            Ir.land_ [ Ir.slen new_atom atom'; Ir.eq (Map.singleton new_atom Z.one) v ]
          | SLen (atom, atom') when (not (is_exp atom')) && Map.mem map atom' ->
            let new_atom = Ir.internal () in
            let v = Extra.model_to_int (Map.find_exn map atom') in
            Ir.land_ [ Ir.slen atom new_atom; Ir.eq (Map.singleton new_atom Z.one) v ]
          (*| SLen (atom, atom') when mem_var_or_pow atom ->
          | SLen (atom, atom') when mem_var_or_pow atom' ->
            let new_atom' = Ir.internal () in
            let v = Extra.model_to_int (Map.find_exn map (get_exp atom')) in
            Ir.land_ [ Ir.slen atom new_atom'; Ir.eq (Map.singleton new_atom' Z.one) v ]*)
          (*| Ast.Var x -> *)
          (*  Base.Option.value ~default:(Ast.Var x) (Map.find map x |> Option.map Ast.const) *)
          (*| Ast.Pow (2, Ast.Const c) -> Ast.Const (pow2 c) *)
          (*| Ast.Pow _ as t -> failwith (Format.asprintf "unimplemented: %a" Ast.pp_term t) *)
          | x -> x)
      in
      Debug.printfln "Formula after substituting exponents: %a" Ir.pp f;
      let f = f |> Ir.simpl |> Ir.simpl_ineq in
      (* Debug.printfln "Formula after simplifications: %a" Ir.pp f; *)
      let model = get_model_normal f () in
      Map.merge map model ~f:(fun ~key -> function
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
               (Extra.nat_model_to_int y)))
  ;;

  let get_model_semenov f s order (model, len) models =
    fun () ->
    match get_model_semenov_exn f s order (model, len) models () with
    | m -> Result.Ok m
    | exception Too_long_model ->
      let ir = Ir.shrink_strings f in
      (match get_model_semenov_exn ir s order (model, len) models () with
       | m -> Result.Ok m
       | exception Too_long_model -> Result.Error `Too_long)
  ;;

  let check_sat ir
    : [ `Sat of unit -> ((Ir.atom, Nfa.v list) Map.t, [ `Too_long ]) Result.t
      | `Unsat
      | `Unknown
      ]
    =
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
        | Some _ -> `Sat (fun () -> failwith "No model can be generated due to config")
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
        | None -> `Unsat
        | Some (s, order, (model, len), models) ->
          `Sat (get_model_semenov ir s order (model, len) models)
        (* (match get_model_semenov ir s order (model, len) models with
             | `Cant_get_model -> `Sat (Result.Error `Too_long)
             | `Ok x -> `Sat (Result.Ok x)) *)
        end)
    else (
      let free_vars = Ir.collect_free ir in
      let ir' = Ir.exists (free_vars |> Set.to_list) ir in
      Debug.printf "Trying to use automatic decision procedure over %a\n" Ir.pp ir;
      if ir' |> eval |> fst |> Nfa.run
      then `Sat (fun () -> Result.Ok (get_model_normal ir ()))
      else `Unsat)
  ;;
end

module LsbStr =
  Make (Nfa.Lsb (Nfa.Str)) (NfaCollection.LsbStr) (Nfa.Lsb (Nfa.Str))
    (NfaCollection.LsbStr)
    (struct
      module NfaO = Nfa
      module Str = Nfa.Str
      module Nfa = Nfa.Lsb (Nfa.Str)

      let eval_reg _vars _reg _atoms = failwith "not implemented for string theory"

      let eval_sreg vars atom reg =
        let nfa = reg |> NfaS.of_regex in
        Debug.dump_nfa ~msg:"SREG %s" ~vars:(Map.to_alist vars) Nfa.format_nfa nfa;
        (*let reenum = Map.singleton (Map.find_exn vars atom) 0 in*)
        let reenum = Map.singleton (Map.find_exn vars atom) 0 in
        Nfa.reenumerate reenum nfa
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
      let char_to_v c = c
    end)

let strbv_to_char =
  let module StrBv = Nfa.StrBv in
  let module Str = Nfa.Str in
  function
  | c when c = StrBv.u_eos -> Str.u_eos
  | c when c = StrBv.u_null -> '0'
  | c -> Z.log2 c |> fun i -> Char.chr (Char.code '0' + i)
;;

let char_to_strbv =
  let module StrBv = Nfa.StrBv in
  let module Str = Nfa.Str in
  function
  | '0' .. '9' as c -> Z.pow (Z.of_int 2) (Char.code c - Char.code '0')
  | c when c = Str.u_eos -> StrBv.u_eos
  | c when c = Str.u_null -> StrBv.u_null
  | _ -> assert false
;;

module LsbStrBv =
  Make (Nfa.Lsb (Nfa.StrBv)) (NfaCollection.LsbStrBv) (Nfa.Lsb (Nfa.StrBv))
    (NfaCollection.LsbStrBv)
    (struct
      module NfaO = Nfa
      module Str = Nfa.StrBv
      module Nfa = Nfa.Lsb (Nfa.StrBv)

      let eval_reg _vars _reg _atoms = failwith "not implemented for string theory"

      let eval_sreg vars atom reg =
        let nfa = reg |> NfaS.of_regex in
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
    end)

module MsbStr =
  Make (Nfa.MsbNat (Nfa.Str)) (NfaCollection.MsbNatStr) (Nfa.Msb (Nfa.Str))
    (NfaCollection.MsbStr)
    (struct
      module NfaO = Nfa
      module Str = Nfa.Str
      module NfaO2 = Nfa.Msb (Str)
      module Nfa = Nfa.Msb (Str)

      let z_of_list_msb_nat_str p =
        p
        |> List.to_seq
        |> Seq.filter (fun c -> c <> Str.u_eos)
        |> Seq.map (fun c -> if c = Str.u_null then '0' else c)
        |> String.of_seq
        |> Z.of_string
      ;;

      let z_of_list_msb_str p =
        let sign, p =
          match p with
          | hd :: tl ->
            (if hd = Str.u_zero || hd = Str.u_eos then Z.one else Z.minus_one), tl
          | _ -> failwith "unreachable"
        in
        p
        |> List.to_seq
        |> Seq.filter (fun c -> c <> Str.u_eos)
        |> Seq.map (fun c -> if c = Str.u_null then '0' else c)
        |> String.of_seq
        |> Z.of_string
        |> Z.mul sign
      ;;

      let eval_reg _vars _reg _atoms = failwith "not implemented for string theory"

      let eval_sreg vars atom reg =
        let nfa = reg |> NfaO2.of_regex in
        let reenum = Map.singleton (Map.find_exn vars atom) 0 in
        Nfa.reenumerate reenum nfa
      ;;

      let eval_sregraw : (Ir.atom, int) Map.t -> Ir.atom -> NfaS.u -> Nfa.t =
        fun vars atom reg ->
        let nfa = reg |> NfaO2.of_lsb in
        let reenum = Map.singleton (Map.find_exn vars atom) 0 in
        Nfa.reenumerate reenum nfa
      ;;

      let model_to_int = z_of_list_msb_str
      let nat_model_to_int = z_of_list_msb_nat_str
      let char_to_v c = c
    end)

module MsbStrBv =
  Make (Nfa.MsbNat (Nfa.StrBv)) (NfaCollection.MsbNatStrBv) (Nfa.Msb (Nfa.StrBv))
    (NfaCollection.MsbStrBv)
    (struct
      module NfaO = Nfa
      module NfaO2 = Nfa.Msb (Nfa.Str)
      module Str = Nfa.StrBv
      module Nfa = Nfa.Msb (Nfa.StrBv)

      let z_of_list_msb_nat_str p =
        p
        |> List.to_seq
        |> Seq.filter (fun c -> c <> Str.u_eos)
        |> Seq.map (fun c -> if c = Str.u_null then '0' else strbv_to_char c)
        |> String.of_seq
        |> Z.of_string
      ;;

      let z_of_list_msb_str p =
        let sign, p =
          match p with
          | hd :: tl ->
            (if hd = Str.u_zero || hd = Str.u_eos then Z.one else Z.minus_one), tl
          | _ -> failwith "unreachable"
        in
        p
        |> List.to_seq
        |> Seq.filter (fun c -> c <> Str.u_eos)
        |> Seq.map (fun c -> if c = Str.u_null then '0' else strbv_to_char c)
        |> String.of_seq
        |> Z.of_string
        |> Z.mul sign
      ;;

      let eval_reg _vars _reg _atoms = failwith "not implemented for string theory"

      let eval_sreg vars atom reg =
        let nfa = reg |> NfaO2.of_regex in
        let nfa = nfa |> NfaO.convert_nfa_msb in
        let reenum = Map.singleton (Map.find_exn vars atom) 0 in
        Nfa.reenumerate reenum nfa
      ;;

      let eval_sregraw : (Ir.atom, int) Map.t -> Ir.atom -> NfaS.u -> Nfa.t =
        fun vars atom reg ->
        let nfa = reg |> NfaO2.of_lsb in
        let nfa = nfa |> NfaO.convert_nfa_msb in
        let reenum = Map.singleton (Map.find_exn vars atom) 0 in
        Nfa.reenumerate reenum nfa
      ;;

      let model_to_int = z_of_list_msb_str
      let nat_model_to_int = z_of_list_msb_nat_str
      let char_to_v = char_to_strbv
    end)

let z_of_list_lsb p =
  let length = List.length p in
  let bv_init deg f =
    List.fold_left
      (fun acc v -> if f v then Z.logor acc (Z.shift_left Z.one v) else acc)
      Z.zero
      (0 -- (deg - 1))
  in
  bv_init length (fun i -> List.nth p i)
;;

module Lsb =
  Make (Nfa.Lsb (Nfa.Bv)) (NfaCollection.Lsb) (Nfa.Lsb (Nfa.Bv)) (NfaCollection.Lsb)
    (struct
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

      let model_to_int c = z_of_list_lsb c
      let nat_model_to_int = model_to_int
      let char_to_v _ = failwith "string constraints are not supported in EIA mode"
    end)

let z_of_list_msb p =
  let sign, p =
    match p with
    | hd :: tl -> (if not hd then Z.one else Z.minus_one), tl
    | _ -> failwith "unreachable"
  in
  let p = List.rev p in
  let length = List.length p in
  let bv_init deg f =
    List.fold_left
      (fun acc v -> if f v then Z.logor acc (Z.shift_left Z.one v) else acc)
      Z.zero
      (0 -- (deg - 1))
  in
  Z.mul (bv_init length (fun i -> List.nth p i)) sign
;;

let z_of_list_msb_nat p =
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

module Msb =
  Make (Nfa.MsbNat (Nfa.Bv)) (NfaCollection.MsbNat) (Nfa.Msb (Nfa.Bv)) (NfaCollection.Msb)
    (struct
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

      let model_to_int c = z_of_list_msb c
      let nat_model_to_int = z_of_list_msb_nat
      let char_to_v _ = failwith "string constraints are not supported in EIA mode"
    end)

let is_internal = String.starts_with ~prefix:"%"

let filter_internal =
  Map.filter_keys ~f:(function
    | Ir.Var s -> not (is_internal s)
    | _ -> true)
;;

let ( let* ) = Result.bind
let return = Result.ok

let z_of_list_str p =
  let sign, p =
    if Config.config.mode = `Lsb
    then Z.one, List.rev p
    else (
      let sign, p =
        match p with
        | hd :: tl -> (if hd = '0' || hd == Nfa.Str.u_eos then Z.one else Z.minus_one), tl
        | _ -> failwith "unreachable"
      in
      sign, p)
  in
  p
  |> List.to_seq
  |> Seq.filter (fun c -> c <> Nfa.Str.u_eos)
  |> Seq.map (fun c -> if c = Nfa.Str.u_null then '0' else c)
  |> (fun s -> if sign = Z.one then s else Seq.append (List.to_seq [ '-' ]) s)
  |> String.of_seq
;;

let check_sat ir
  : [ `Sat of (Ir.atom, [ `Str | `Int ]) Map.t -> (Ir.model, [ `Too_long ]) Result.t
    | `Unsat
    | `Unknown of Ir.t
    ]
  =
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
       | Result.Ok model ->
         let f tys =
           Result.Ok
             (model
              |> Map.mapi ~f:(fun ~key:k ~data:v ->
                match Map.find tys k with
                | None | Some `Int ->
                  let v =
                    if Config.config.mode = `Lsb then z_of_list_lsb v else z_of_list_msb v
                  in
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
                  failwith "it is something strange: there is string variable in EIA")
              |> Map.map_keys_exn ~f:(function
                | Ir.Pow2 k as atom -> get_exp atom
                | atom -> atom)
              |> filter_internal)
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
      match Config.config.logic, Config.config.mode with
      | `Str, `Lsb -> LsbStr.check_sat
      | `Str, `Msb -> MsbStr.check_sat
      | `StrBv, `Lsb -> wrap LsbStrBv.check_sat
      | `StrBv, `Msb -> wrap MsbStrBv.check_sat
      | _ -> assert false
    in
    match checker ir with
    | `Sat model ->
      `Sat
        (fun tys ->
          let* model = model () in
          let main_model =
            Map.mapi
              ~f:(fun ~key:k ~data:v ->
                let ty = Map.find tys k |> Option.value ~default:`Int in
                match ty with
                | `Int -> begin
                  try
                    let s = v |> z_of_list_str in
                    if String.length s > 0 then `Int (Z.of_string s) else `Int Z.zero
                  with
                  | Invalid_argument _ -> `Str (v |> z_of_list_str)
                end
                | `Str -> `Str (v |> z_of_list_str))
              model
          in
          return main_model)
    | `Unsat -> `Unsat
    | `Unknown -> `Unknown ir
  in
  match Config.config.logic with
  | `Eia -> on_no_strings ir
  | `Str | `StrBv -> on_strings ir
;;
