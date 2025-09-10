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

let collect_vars ir =
  Ir.fold
    (fun acc -> function
       (*| Ir.Exists (atoms, _) -> Set.union acc (Set.of_list atoms)*)
       | Ir.Reg (_, atoms) -> Set.union acc (atoms |> Set.of_list)
       | Ir.SReg (atom, _) -> Set.add acc atom
       | Ir.SLen (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Ir.SEq (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Ir.Stoi (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Ir.Rel (_, term, _) ->
         Set.union
           acc
           (Map.keys term
            |> List.concat_map (function
              | Ir.Var _ as ir -> [ ir ]
              | Ir.Pow2 a as ir -> [ ir; Ir.var a ])
            |> Set.of_list)
       | _ -> acc)
    Set.empty
    ir
  |> Set.to_list
  |> List.mapi (fun i var -> var, i)
  |> Map.of_alist_exn
;;

let collect_free (ir : Ir.t) =
  Ir.fold
    (fun acc -> function
       | Ir.Rel (_, term, _) -> term |> Map.keys |> Set.of_list |> Set.union acc
       | Ir.SReg (atom, _) -> Set.add acc atom
       | Ir.SLen (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Ir.Stoi (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Ir.SEq (atom, atom') -> Set.add (Set.add acc atom) atom'
       | Ir.Reg (_, atoms) -> Set.union acc (atoms |> Set.of_list)
       | Ir.Exists (xs, _) -> Set.diff acc (Set.of_list xs)
       | _ -> acc)
    Set.empty
    ir
;;

let ( -- ) i j =
  let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
  aux j []
;;

(*type bound =
  | EqConst of Ir.atom * int
  | LeqConst of (Ir.atom, int) Map.t * int
  | EqVar of Ir.atom * Ir.atom
*)

let trivial ir =
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
           && Map.nth_exn term 1 |> snd = 1 ->
      let v1 = Map.nth_exn term 0 |> fst in
      let v2 = Map.nth_exn term 1 |> fst in
      Set.singleton (EqVar (v1, v2))
    | Rel (Ir.Eq, term, 0)
      when Map.length term = 2
           && Map.nth_exn term 0 |> snd = 1
           && Map.nth_exn term 1 |> snd = -1 ->
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
  let quantifiers_closer : Ir.t -> Ir.t =
    Ir.map (function
      | Ir.Exists ([], ir) -> ir
      | Ir.Exists (atoms, Ir.Exists (atoms', ir)) -> Ir.exists (atoms @ atoms') ir
      | Ir.Exists (atoms, Ir.Land irs) ->
        let atoms_set = atoms |> Set.of_list in
        let irs_using_var =
          List.mapi
            begin
              fun i ir ->
                let free_vars = collect_free ir in
                let used_vars = Set.inter atoms_set free_vars in
                i, used_vars
            end
            irs
        in
        let var_is_used_in =
          List.map
            begin
              fun atom ->
                ( atom
                , List.filter_map
                    (fun (i, s) -> if Set.mem s atom then Some i else None)
                    irs_using_var )
            end
            atoms
          |> Map.of_alist_exn
        in
        let atoms, irs =
          List.fold_left
            begin
              fun (atoms, irs) (atom, used_in) ->
                match used_in with
                | [] -> atoms, irs
                | [ i ] ->
                  ( atoms
                  , List.mapi
                      (fun j ir -> if i = j then Ir.exists [ atom ] ir else ir)
                      irs )
                | _ -> atom :: atoms, irs
            end
            ([], irs)
            (var_is_used_in
             |> Map.to_alist
             |> List.sort (fun (_, used_in) (_, used_in') ->
               List.length used_in' - List.length used_in))
        in
        Ir.exists atoms (Ir.land_ irs)
      | Ir.Exists (atoms, Ir.Lor irs) -> Ir.lor_ (List.map (Ir.exists atoms) irs)
      | ir -> ir)
  in
  let simpl ir =
    ir
    |> Ir.map (function
      | Ir.Rel (Ir.Eq, term, c)
        when Map.for_all ~f:(fun v -> Z.(equal v zero)) term && c = Z.zero -> Ir.true_
      | Ir.Rel (Ir.Leq, term, c) when Map.length term = 0 && Z.(c >= zero) -> Ir.true_
      | Ir.Rel (Ir.Leq, term, c) when Map.length term = 0 && Z.(c < zero) -> Ir.false_
      | ir -> ir)
    |> Ir.map (function
      | Ir.Lor [] -> Ir.false_
      | Ir.Land [] -> Ir.true_
      | Ir.Land [ ir ] -> ir
      | Ir.Lor [ ir ] -> ir
      | Ir.Land irs
        when List.exists
               (function
                 | Ir.Lnot Ir.True -> true
                 | _ -> false)
               irs -> Ir.Lnot Ir.True
      | Ir.Land irs ->
        Ir.land_
          (List.filter_map
             (function
               | Ir.True -> None
               | ir' -> Some ir')
             irs)
      | Ir.Lor irs
        when List.exists
               (function
                 | Ir.True -> true
                 | _ -> false)
               irs -> Ir.True
      | Ir.Lor irs ->
        Ir.lor_
          (List.filter_map
             (function
               | Ir.Lnot Ir.True -> None
               | ir' -> Some ir')
             irs)
      | ir -> ir)
    |> Ir.map (function
      | Ir.Land lst ->
        Ir.Land
          (lst
           |> List.concat_map (function
             | Ir.Land lst -> lst
             | ir -> [ ir ]))
      | Ir.Lor lst ->
        Ir.Lor
          (lst
           |> List.concat_map (function
             | Ir.Lor lst -> lst
             | ir -> [ ir ]))
      | ir -> ir)
  in
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
    let ir' = (*aux *) ir |> simpl |> quantifiers_closer in
    if Ir.equal ir ir' then ir' else aux2 ir'
  in
  aux2 ir
;;

let level = ref 0

module Make
    (NfaNat : Nfa.NatType)
    (NfaCollectionNat : NfaCollection.NatType with type t = NfaNat.t)
    (Nfa : Nfa.Type with type u = NfaNat.t and type v = NfaNat.v)
    (NfaCollection : NfaCollection.Type with type t = Nfa.t)
    (Extra : sig
       val eval_sreg : (Ir.atom, int) Map.t -> Ir.atom -> char list Regex.t -> Nfa.t
       val eval_reg : (Ir.atom, int) Map.t -> bool list Regex.t -> Ir.atom list -> Nfa.t
       val model_to_int : Nfa.v list -> Z.t
     end) =
struct
  let is_exp = function
    | Ir.Pow2 _ -> true
    | Ir.Var _ -> false
  ;;

  let eval ir =
    (*let ir = if config.logic = `Eia then trivial ir else ir in*)
    let ir = trivial ir in
    let ir = if Config.v.simpl_mono then Ir.simpl_monotonicty ir else ir in
    let ir = if Config.v.simpl_alpha then Simpl_alpha.simplify ir else ir in
    (* Printf.printf "%s %d\n%!" __FILE__ __LINE__; *)
    if Config.v.dump_simpl then Format.printf "%a\n%!" Ir.pp_smtlib2 ir;
    if Config.v.stop_after = `Simpl then exit 0;
    let vars = collect_vars ir in
    let apply_post_strings atoms =
      fun nfa ->
      let slens =
        Ir.fold
          (fun acc -> function
             | SLen (atom, atom') -> (atom, atom') :: acc
             | _ -> acc)
          []
          ir
      in
      let stois =
        Ir.fold
          (fun acc -> function
             | Stoi (atom, atom') -> (atom, atom') :: acc
             | _ -> acc)
          []
          ir
      in
      let seqs =
        Ir.fold
          (fun acc -> function
             | SEq (atom, atom') -> (atom, atom') :: acc
             | _ -> acc)
          []
          ir
      in
      let nfa =
        List.fold_left
          (fun nfa (atom, atom') ->
             if List.mem atom atoms
             then
               NfaCollection.strlen
                 nfa
                 ~src:(Map.find_exn vars atom')
                 ~dest:(Map.find_exn vars atom)
             else nfa)
          nfa
          slens
      in
      Debug.dump_nfa
        ~msg:"After evaluating strlen %s"
        ~vars:(Map.to_alist vars)
        Nfa.format_nfa
        nfa;
      let nfa =
        List.fold_left
          (fun nfa (atom, atom') ->
             if List.mem atom atoms
             then
               NfaCollection.stoi
                 nfa
                 ~src:(Map.find_exn vars atom')
                 ~dest:(Map.find_exn vars atom)
             else nfa)
          nfa
          stois
      in
      Debug.dump_nfa
        ~msg:"After evaluating stoi %s"
        ~vars:(Map.to_alist vars)
        Nfa.format_nfa
        nfa;
      let nfa =
        List.fold_left
          (fun nfa (atom, atom') ->
             if List.mem atom atoms
             then
               NfaCollection.seq
                 nfa
                 ~src:(Map.find_exn vars atom')
                 ~dest:(Map.find_exn vars atom)
             else nfa)
          nfa
          seqs
      in
      Debug.dump_nfa
        ~msg:"After evaluating seqs %s"
        ~vars:(Map.to_alist vars)
        Nfa.format_nfa
        nfa;
      nfa
    in
    let rec eval ir =
      if Config.v.dump_ir then Format.printf "%d Running %a\n%!" !level Ir.pp ir;
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
                (* Format.printf "Nfa for %a has %d nodes\n%!" Ir.pp ir (Nfa.length nfa);*)
                nfa)
             irs
           |> List.sort (fun nfa1 nfa2 -> Nfa.length nfa1 - Nfa.length nfa2)
         in
         let rec eval_and = function
           | hd :: [] -> hd
           | hd :: hd' :: tl ->
             (* Format.printf "Intersecting %d %d\n%!" (Nfa.length hd) (Nfa.length hd'); *)
             let nfa = Nfa.intersect hd hd' in
             let nfas =
               nfa :: tl |> List.sort (fun nfa1 nfa2 -> Nfa.length nfa1 - Nfa.length nfa2)
             in
             eval_and nfas
           | [] -> NfaCollection.n ()
         in
         eval_and nfas
       | Ir.Lor (hd :: tl) ->
         List.fold_left (fun nfa ir -> eval ir |> Nfa.unite nfa) (eval hd) tl
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
                 then Nfa.intersect acc (NfaCollection.power_of_two v)
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
                 then Nfa.intersect acc (NfaCollection.power_of_two v)
                 else acc)
               vars
           in
           nfa
       end
       | Ir.Reg (reg, atoms) -> Extra.eval_reg vars reg atoms
       | Ir.Exists (atoms, ir) ->
         eval ir
         |> apply_post_strings atoms
         |> Nfa.project (List.filter_map (Map.find vars) atoms)
         |> Nfa.minimize
         (* APOHZ technique legacy.
           |> NfaO.lsb_of_msb:
           |> NfaO.Lsb.minimize
           |> NfaO.msb_of_lsb
         *)
       | Ir.SReg (atom, reg) -> Extra.eval_sreg vars atom reg
       | Ir.SLen (atom, atom') -> NfaCollection.n ()
       | Ir.Stoi (atom, atom') -> NfaCollection.n ()
       | Ir.SEq (atom, atom') -> NfaCollection.n ()
       | _ -> Format.asprintf "Unsupported IR %a to evaluate to" Ir.pp ir |> failwith)
      |> fun nfa ->
      Debug.printfln "Done %a\n%!" Ir.pp ir;
      Debug.dump_nfa ~msg:"Evaluated %s" ~vars:(Map.to_alist vars) Nfa.format_nfa nfa;
      level := !level - 1;
      nfa
    in
    let nfa = eval ir in
    let nfa = apply_post_strings (collect_free ir |> Set.to_list) nfa in
    nfa, vars
  ;;

  let logBase n =
    let rec helper acc = function
      | 0 -> acc
      | n -> helper (acc + 1) (n / NfaCollection.base)
    in
    helper (-1) n
  ;;

  let pow2z n =
    List.init (Z.to_int n) (Fun.const (NfaCollection.base |> Z.of_int))
    |> List.fold_left Z.( * ) Z.one
  ;;

  let get_exp = function
    | Ir.Pow2 var -> Ir.var var
    | Ir.Var _ -> failwith "Expected exponent, found var"
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
    chrob
    |> List.to_seq
    |> Seq.map (fun (a, c) ->
      let a_var, s = internal s in
      let var2_plus_a, s = internal s in
      let t, s = internal s in
      let c_mul_t, s = internal s in
      let get_deg = Map.find_exn s.vars in
      Debug.printfln
        "nfa_for_exponent2: internal_counter=%d var=%a var2=%a"
        s.internal_counter
        Ir.pp_atom
        var
        Ir.pp_atom
        var2;
      (*Debug.printfln "[ var2_plus_a; c_mul_t; t ] = [%d; %d; %d]" var2_plus_a c_mul_t t;*)
      let poly = Map.of_alist_exn [ var2, Z.one; t, Z.of_int c; var, Z.minus_one ] in
      let nfa' = NfaCollection.eq s.vars poly (Z.of_int (-a)) in
      let nfa =
        Nfa.project [ get_deg t ] (*var2 + a + c * t = var*) nfa'
        (*(Nfa.intersect
             (NfaCollection.add ~lhs:var2_plus_a ~rhs:c_mul_t ~res:var)
             (Nfa.intersect
                (Nfa.intersect
                   (NfaCollection.add ~res:var2_plus_a ~lhs:var2 ~rhs:a_var)
                   (NfaCollection.eq_const a_var a))
                (NfaCollection.mul ~res:c_mul_t ~lhs:c ~rhs:t)))*)
      in
      Debug.dump_nfa ~msg:"nfa_for_exponent2 output nfa: %s" Nfa.format_nfa nfa;
      nfa)
  ;;

  let nfa_for_exponent s var newvar chrob =
    let module Nfa = NfaNat in
    let module NfaCollection = NfaCollectionNat in
    chrob
    |> List.to_seq
    |> Seq.concat_map (fun (a, c) ->
      if c = 0
      then
        Seq.init (a + 10) (( + ) a)
        |> Seq.map (fun x ->
          let log = logBase x in
          x - log, log, 0)
        |> Seq.filter (fun (t, _, _) -> t = a)
      else 0 -- (c - 1) |> List.map (fun d -> a, d, c) |> List.to_seq)
    |> Seq.map (fun (a, d, c) ->
      let a_plus_d, s = internal s in
      let t, s = internal s in
      let c_mul_t, s = internal s in
      let internal, s = internal s in
      let get_deg = Map.find_exn s.vars in
      let poly = Map.of_alist_exn [ t, Z.of_int (-c); var, Z.one ] in
      let nfa' = NfaCollection.eq s.vars poly (Z.of_int (a + d)) in
      let nfa = Nfa.project [ get_deg t ] nfa' in
      (*var = a + d + c * t*)
      let n =
        List.init (a + 2) (( + ) a)
        |> List.filter (fun x -> x - logBase x >= a)
        |> List.hd
      in
      Debug.printfln "nfa_for_exponent: a=%d, d=%d, c=%d, n=%d" a d c n;
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
      nfa)
  ;;

  let project_exp s nfa x next =
    let module Nfa = NfaNat in
    let module NfaCollection = NfaCollectionNat in
    Debug.dump_nfa
      ~msg:"Nfa inside project_exp: %s"
      ~vars:(Map.to_alist s.vars)
      Nfa.format_nfa
      nfa;
    let inter, s = internal s in
    let get_deg = Map.find_exn s.vars in
    let x' = get_exp x in
    if is_exp next
    then
      nfa
      |> Nfa.get_chrobaks_sub_nfas
           ~res:(get_deg x)
           ~temp:(get_deg next)
           ~vars:(Map.data s.vars)
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
           ~vars:(Map.data s.vars)
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
    let rec helper nfa order model =
      Debug.dump_nfa
        ~msg:"Nfa inside proof_order: %s"
        ~vars:(Map.to_alist s.vars)
        Nfa.format_nfa
        nfa;
      match order with
      | [] -> return s nfa model
      | x :: [] -> return s (project (get_deg x) nfa) model
      | x :: (next :: _ as tl) ->
        if not (is_exp x)
        then helper (project (get_deg x) nfa) tl model
        else (
          let deg = (Map.max_elt_exn s.vars |> snd) + 2 in
          let x' = get_exp x in
          let zero_nfa =
            Nfa.intersect
              (NfaCollection.eq s.vars (Map.singleton x Z.one) Z.one)
              (NfaCollection.eq s.vars (Map.singleton x' Z.one) Z.zero)
            |> Nfa.truncate deg
            |> Nfa.intersect nfa
            |> project (get_deg x)
          in
          Debug.printf "Zero nfa for %a: " Ir.pp_atom x;
          Debug.dump_nfa ~msg:"%s" Nfa.format_nfa zero_nfa;
          match helper zero_nfa tl model with
          | Some _ as res -> res
          | None ->
            Debug.printfln "%a > 1:" Ir.pp_atom x;
            project_exp s nfa x next
            |> Seq.map (fun (nfa, model_part) ->
              helper (Nfa.minimize (project (get_deg x) nfa)) tl (model_part :: model))
            |> Seq.find_map Fun.id)
    in
    helper nfa order []
  ;;

  let prepare_order s nfa order =
    Debug.printfln
      "Trying order %a"
      (Format.pp_print_list ~pp_sep:(fun ppf () -> Format.fprintf ppf " <= ") Ir.pp_atom)
      (order |> List.rev);
    let len = List.length order in
    let nfa =
      if len <= 1
      then nfa
      else (
        let order_nfa, order_vars =
          eval
            (Seq.zip
               (order |> List.to_seq |> Seq.take (len - 1))
               (order |> List.to_seq |> Seq.drop 1)
             |> Seq.map (fun (x, y) ->
               let term = [ x, Z.one; y, Z.minus_one ] |> Map.of_alist_exn in
               Ir.geq term Z.zero)
             |> List.of_seq
             |> function
             | [] -> failwith ""
             | comps -> Ir.land_ comps)
        in
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
        NfaNat.intersect nfa order_nfa |> NfaNat.minimize)
    in
    Debug.dump_nfa ~msg:"NFA taking order into account: %s" NfaNat.format_nfa nfa;
    order, nfa
  ;;

  let eval_semenov return next formula =
    Memtrace.trace_if_requested ~context:"my program" ();
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
    let vars = collect_vars formula in
    let formula =
      formula
      |> Ir.exists
           (vars
            |> Map.keys
            |> List.filter (fun var ->
              (not (is_exp var)) && not (Map.mem vars (to_exp var))))
    in
    let nfa, vars = eval formula in
    let nfa =
      Map.fold
        ~init:nfa
        ~f:(fun ~key:k ~data:v acc ->
          if is_exp k then Nfa.intersect acc (NfaCollection.power_of_two v) else acc)
        vars
    in
    let nfa = nfa |> Nfa.to_nat |> NfaNat.minimize in
    Debug.dump_nfa
      ~msg:"Minimized nfa with projected linear-only variables: %s"
      ~vars:(Map.to_alist vars)
      NfaNat.format_nfa
      nfa;
    let powered_vars =
      Map.filteri ~f:(fun ~key:k ~data:_ -> is_exp k || Map.mem vars (to_exp k)) vars
    in
    let s = { vars = powered_vars; internal_counter = 0 } in
    decide_order powered_vars
    |> List.to_seq
    |> Seq.map (prepare_order s nfa)
    (*Filtering of orderings w.r.t. the simple overapproximation idea: 
      1) exponent is a power of the base; 
      2) exp(base, x) >= (base -1)*x + 1
    *)
    |> Seq.filter (function order, nfa ->
        let nfa_with_over =
          nfa
          |> List.fold_right
               NfaNat.intersect
               (powered_vars
                |> Map.keys
                |> List.filter (fun x -> is_exp x)
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
    |> Seq.map (fun (order, nfa) -> proof_order return next s nfa order)
    |> Seq.find (function
      | Some _ -> true
      | None -> false)
    |> function
    | Some x -> x
    | None -> None
  ;;

  let proof_semenov f =
    Debug.printf "Trying to use Semenov deciding procedure over %a\n" Ir.pp f;
    match
      f
      |> eval_semenov
           (fun _ nfa _ -> if NfaNat.run nfa then Some () else None)
           (fun x nfa -> NfaNat.project [ x ] nfa)
    with
    | Some _ -> `Sat
    | None -> `Unsat
  ;;

  let get_model_normal f =
    let nfa, vars = f |> eval in
    let free_vars = f |> collect_free |> Set.to_list in
    Nfa.any_path nfa (List.map (fun v -> Map.find_exn vars v) free_vars)
    |> Option.map (fun (model, _) ->
      model |> List.mapi (fun i v -> List.nth free_vars i, v) |> Map.of_alist_exn)
  ;;

  let get_model_semenov f =
    let res =
      f
      |> eval_semenov
           (fun s nfa model ->
              match NfaNat.any_path nfa (Map.data s.vars) with
              | Some path -> Some (s, path, model)
              | None -> None)
           (fun _ nfa -> nfa)
    in
    match res with
    | Some (s, model, models) ->
      let ( let* ) = Option.bind in
      let map =
        NfaNat.combine_model_pieces (model :: models)
        |> List.mapi (fun i v -> i, v)
        |> List.filter_map (fun (i, v) ->
          let* sup = List.nth_opt (Map.keys s.vars) i in
          Option.some (sup, v))
        |> List.mapi (fun i (atom, v) -> atom, v)
        |> Map.of_alist_exn
      in
      let map = Map.filter_keys map ~f:(fun key -> not (is_exp key)) in
      Debug.printfln "Formula before substituting exponents: %a" Ir.pp f;
      Debug.printfln
        "Variable map: %a"
        (Format.pp_print_list
           ~pp_sep:(fun fmt () -> Format.fprintf fmt "\n")
           (fun fmt (a, b) ->
              Format.fprintf fmt "%a -> %a" Ir.pp_atom a Z.pp_print (Extra.model_to_int b)))
        (Map.to_alist map);
      let f =
        f
        |> Ir.map (function
          | Ir.Rel (rel, term, c) ->
            let filter =
              fun k ->
              match k with
              | Ir.Pow2 _ -> true
              | Ir.Var _ -> Map.mem map k
            in
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
          (*| Ast.Var x -> *)
          (*  Base.Option.value ~default:(Ast.Var x) (Map.find map x |> Option.map Ast.const) *)
          (*| Ast.Pow (2, Ast.Const c) -> Ast.Const (pow2 c) *)
          (*| Ast.Pow _ as t -> failwith (Format.asprintf "unimplemented: %a" Ast.pp_term t) *)
          | x -> x)
      in
      Debug.printfln "Formula after substituting exponents: %a" Ir.pp f;
      let model = get_model_normal f in
      Map.merge map (Option.get model) ~f:(fun ~key:_ -> function
        | `Left x -> Some x
        | `Right x -> Some x
        | `Both _ -> failwith "Should be unreachable")
      |> Option.some
    | None -> None
  ;;

  let proof ir =
    let run_semenov = collect_vars ir |> Map.keys |> List.exists is_exp in
    if run_semenov
    then proof_semenov ir
    else (
      (*let f = Optimizer.optimize f in
      Debug.printfln "optimized formula: %a" Ast.pp_formula f;*)
      let free_vars = collect_free ir in
      let ir = Ir.exists (free_vars |> Set.to_list) ir in
      Debug.printf "Trying to use PrA deciding procedure over  %a\n" Ir.pp ir;
      if ir |> eval |> fst |> Nfa.run then `Sat else `Unsat)
  ;;

  let get_model f =
    let run_semenov = collect_vars f |> Map.keys |> List.exists is_exp in
    if run_semenov then get_model_semenov f else get_model_normal f
  ;;
end

module LsbStr =
  Make (Nfa.Lsb (Nfa.Str)) (NfaCollection.Str) (Nfa.Lsb (Nfa.Str)) (NfaCollection.Str)
    (struct
      module Str = Nfa.Str
      module Nfa = Nfa.Lsb (Nfa.Str)

      let eval_reg _vars _reg _atoms = failwith "not implemented for string theory"

      let eval_sreg vars atom reg =
        let nfa = reg |> Nfa.of_regex in
        Debug.dump_nfa ~msg:"SREG %s" ~vars:(Map.to_alist vars) Nfa.format_nfa nfa;
        (*let reenum = Map.singleton (Map.find_exn vars atom) 0 in*)
        let j = Map.find_exn vars atom in
        Nfa.filter_map nfa (fun (label, q') ->
          Some
            ( Array.init (Map.length vars) (fun i ->
                if i = j then label.(0) else Char.chr 0)
            , q' ))
      ;;

      let model_to_int c =
        c
        |> List.to_seq
        |> Seq.drop_while (fun c -> c = '0')
        |> Seq.filter (( <> ) Str.u_eos)
        |> Seq.filter (( <> ) Str.u_null)
        |> List.of_seq
        |> List.rev
        |> List.to_seq
        |> String.of_seq
        |> fun s -> if String.length s = 0 then Z.zero else Z.of_string s
      ;;
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
        let nfa = Nfa.reenumerate reenum nfa in
        nfa
      ;;

      let eval_sreg _vars _atom _regex =
        failwith "string constraints are not supported in EIA mode"
      ;;

      let model_to_int c = z_of_list_lsb c
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
        let nfa = Nfa.reenumerate reenum nfa in
        nfa
      ;;

      let eval_sreg _vars _atom _regex =
        failwith "string constraints are not supported in EIA mode"
      ;;

      let model_to_int c = z_of_list_msb c
    end)

let proof ir =
  match Config.v.logic with
  | `Eia -> begin
    match Config.v.mode with
    | `Lsb -> Lsb.proof ir
    | `Msb -> Msb.proof ir
  end
  | `Str -> LsbStr.proof ir
;;

let get_model ir =
  match Config.v.logic with
  | `Str ->
    LsbStr.get_model ir
    |> Option.map
         (Map.map ~f:(fun v ->
            `Str
              (v
               |> List.rev
               |> List.to_seq
               |> Seq.filter (fun c -> Char.code c <> 0)
               |> String.of_seq)))
  | _ -> begin
    let model =
      match Config.v.mode with
      | `Lsb -> Lsb.get_model ir
      | `Msb -> Msb.get_model ir
    in
    model
    |> Option.map
         (Map.map ~f:(fun v ->
            `Int (if Config.v.mode = `Lsb then z_of_list_lsb v else z_of_list_msb v)))
  end
;;

(*let aux s =
  let res, asts = Smtml.Smtlib.parse_all (`Contents ("", s)) in
  let asts = Lazy.force asts in
  match asts with
  | Smtml.Ast.Assert expr :: [] -> expr |> Fe._to_ir |> Me.ir_of_ast
  | s -> failwith "TBD"
;;
*)
