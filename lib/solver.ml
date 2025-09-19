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
  let quantifiers_closer : Ir.t -> Ir.t =
    fun ir ->
    Ir.map
      (function
        | Ir.Exists ([], ir) -> ir
        | Ir.Exists (atoms, Ir.Exists (atoms', ir)) ->
          Ir.exists (Base.List.dedup_and_sort ~compare (atoms @ atoms')) ir
        | Ir.Exists ((a :: b :: tl as atoms), (Ir.Land irs as ir)) as orig_ir ->
          let atoms =
            List.filter
              (fun atom ->
                 not
                   (Ir.for_some
                      (function
                        | Ir.SReg (atom', _)
                        | Ir.SLen (atom', _)
                        | Ir.Stoi (atom', _)
                        | Ir.SEq (atom', _)
                          when atom = atom' -> true
                        | _ -> false)
                      ir))
              atoms
          in
          let atoms_set = Set.of_list atoms in
          if atoms_set |> Set.is_empty
          then orig_ir
          else (
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
            let atom_to_move, used_in =
              var_is_used_in
              |> Map.to_alist
              |> List.sort (fun (_, used_in) (_, used_in') ->
                List.length used_in - List.length used_in')
              |> List.hd
            in
            if List.length irs = List.length used_in
            then orig_ir
            else (
              let atoms = List.filter (fun atom -> atom <> atom_to_move) atoms in
              let irs_used, irs_free =
                irs
                |> List.mapi (fun i ir -> i, ir)
                |> List.partition (fun (i, ir) -> List.mem i used_in)
              in
              let irs_used = List.map snd irs_used in
              let irs_free = List.map snd irs_free in
              Ir.exists
                atoms
                (Ir.land_ (Ir.exists [ atom_to_move ] (Ir.land_ irs_used) :: irs_free))))
        | Ir.Exists (atoms, Ir.Lor irs) -> Ir.lor_ (List.map (Ir.exists atoms) irs)
        | ir -> ir)
      ir
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

open Config

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
       val nat_model_to_int : NfaNat.v list -> Z.t
     end) =
struct
  let is_exp = function
    | Ir.Pow2 _ -> true
    | Ir.Var _ -> false
  ;;

  let eval ir =
    (*let ir = if Config.v.logic = `Eia then trivial ir else ir in*)
    let ir = trivial ir in
    let ir = if Config.config.simpl_mono then Ir.simpl_monotonicty ir else ir in
    let ir = if Config.config.simpl_alpha then Simpl_alpha.simplify ir else ir in
    (* Printf.printf "%s %d\n%!" __FILE__ __LINE__; *)
    if Config.config.dump_simpl then Format.printf "%a\n%!" Ir.pp_smtlib2 ir;
    if Config.config.stop_after = `Simpl then exit 0;
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
      nfa
    in
    let rec eval ir =
      if Config.config.dump_ir then Format.printf "%d Running %a\n%!" !level Ir.pp ir;
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

  let logBaseZ n =
    let base = Z.of_int NfaCollection.base in
    let rec helper acc n = if n = Z.zero then acc else helper (acc + 1) Z.(n / base) in
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

  let prepare_order s nfa order =
    Debug.printf
      "\n\n\nTrying order %a\n%!"
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
        NfaNat.intersect nfa (order_nfa |> NfaNat.minimize))
    in
    Debug.dump_nfa ~msg:"NFA taking order into account: %s" NfaNat.format_nfa nfa;
    order, nfa
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
          if is_exp k then Nfa.intersect acc (NfaCollection.power_of_two v) else acc)
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
    let nfa =
      nfa |> Nfa.to_nat
      (*|> NfaNat.minimize *)
    in
    Debug.dump_nfa
      ~msg:"Minimized original nfa: %s"
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
        else true)
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
      | [] -> mapVals
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
           let model2 = part path_len |> Option.get in
           let new_model, new_len =
             NfaNat.combine_model_pieces
               (List.map (Map.find_exn mapVals) vars, len)
               model2
           in
           let mapVals = new_model |> Base.List.zip_exn vars |> Map.of_alist_exn in
           helper mapVals new_len tl (exp :: past_order) parts)
    in
    let mapVals = Base.List.zip_exn vars model |> Map.of_alist_exn in
    helper mapVals len order [] models |> Map.map_keys_exn ~f:Ir.var
  ;;

  let get_model_normal ir () =
    let nfa, vars = ir |> eval in
    let free_vars = ir |> collect_free |> Set.to_list in
    let model, _ =
      Nfa.any_path nfa (List.map (fun v -> Map.find_exn vars v) free_vars) |> Option.get
    in
    model |> List.mapi (fun i v -> List.nth free_vars i, v) |> Map.of_alist_exn
  ;;

  let get_model_semenov f s order (model, len) models () =
    let map = combine_model_pieces s (List.rev order) (model, len) models in
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
    let model = get_model_normal f () in
    Map.merge map model ~f:(fun ~key:_ -> function
      | `Left x -> Some x
      | `Right x -> Some x
      | `Both _ -> failwith "Should be unreachable")
  ;;

  let check_sat ir : [ `Sat of unit -> (Ir.atom, Nfa.v list) Map.t | `Unsat | `Unknown ] =
    let run_semenov = collect_vars ir |> Map.keys |> List.exists is_exp in
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
        begin
          match res with
          | Some (s, order, (model, len), models) ->
            `Sat (get_model_semenov ir s order (model, len) models)
          | None -> `Unsat
        end)
    else (
      let free_vars = collect_free ir in
      let ir' = Ir.exists (free_vars |> Set.to_list) ir in
      Debug.printf "Trying to use PrA deciding procedure over  %a\n" Ir.pp ir;
      if ir' |> eval |> fst |> Nfa.run then `Sat (get_model_normal ir) else `Unsat)
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
        |> Seq.filter (( <> ) Str.u_eos)
        |> Seq.filter (( <> ) Str.u_null)
        |> List.of_seq
        |> List.rev
        |> Base.List.drop_while ~f:(( = ) '0')
        |> Base.String.of_list
        |> fun s -> if String.length s = 0 then Z.zero else Z.of_string s
      ;;

      let nat_model_to_int = model_to_int
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

      let model_to_int c = z_of_list_lsb c
      let nat_model_to_int = model_to_int
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

      let model_to_int c = z_of_list_msb c
      let nat_model_to_int = z_of_list_msb_nat
    end)

let ir_atom_to_eia_term : Ir.atom -> Ast.Eia.term = function
  | Ir.Var s -> Ast.Eia.atom (Ast.var s)
  | Ir.Pow2 s ->
    Ast.Eia.pow (Ast.Eia.atom (Ast.const (Config.base ()))) (Ast.Eia.atom (Ast.var s))
;;

let ir_atom_to_str_term : Ir.atom -> Ast.Str.term = function
  | Ir.Var s -> Ast.Str.atom (Ast.var s)
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
    Ast.str (Ast.Str.eq (ir_atom_to_str_term atom) (ir_atom_to_str_term atom'))
  | SLen (atom, atom') ->
    Ast.eia
      (Ast.Eia.eq
         (Ast.Eia.atom (ir_atom_to_atom atom))
         (Ast.Eia.len2 (ir_atom_to_atom atom')))
  | Stoi (atom, atom') ->
    Ast.eia
      (Ast.Eia.eq
         (Ast.Eia.atom (ir_atom_to_atom atom))
         (Ast.Eia.stoi2 (ir_atom_to_atom atom')))
  | Exists (atoms, lhs) -> Ast.exists (List.map ir_atom_to_atom atoms) (ir_to_ast lhs)
;;

let filter_internal =
  Map.filter_keys ~f:(function
    | Ir.Var s -> not (String.starts_with ~prefix:"%" s)
    | _ -> true)
;;

let check_sat ir
  : [ `Sat of (Ir.atom, [ `Str | `Int ]) Map.t -> Ir.model | `Unsat | `Unknown of Ir.t ]
  =
  match Config.config.logic with
  | `Eia ->
    let res =
      match Config.config.mode with
      | `Lsb -> Lsb.check_sat ir
      | `Msb -> Msb.check_sat ir
    in
    begin
      match res with
      | `Sat model ->
        `Sat
          (fun tys ->
            Map.mapi
              ~f:(fun ~key:k ~data:v ->
                let ty = Map.find tys k |> Option.value ~default:`Int in
                match ty with
                | `Int ->
                  `Int
                    (if Config.config.mode = `Lsb
                     then z_of_list_lsb v
                     else z_of_list_msb v)
                | `Str ->
                  failwith "it is something strange: there is string variable in EIA")
              (model ())
            |> filter_internal)
      | `Unsat -> `Unsat
      | `Unknown -> `Unknown ir
    end
  | `Str -> begin
    match ir |> ir_to_ast |> SimplII.run_basic_simplify with
    | `Unknown (ast, env) ->
      let ir = Me.ir_of_ast ast |> Result.get_ok in
      let res = LsbStr.check_sat ir in
      (match res with
       | `Sat model ->
         `Sat
           (fun tys ->
             let main_model =
               Map.mapi
                 ~f:(fun ~key:k ~data:v ->
                   let ty = Map.find tys k |> Option.value ~default:`Int in
                   match ty with
                   | `Int -> begin
                     try
                       `Int (Z.of_string (List.rev v |> List.to_seq |> String.of_seq))
                     with
                     | Invalid_argument _ ->
                       `Str
                         (v
                          |> List.rev
                          |> List.to_seq
                          |> Seq.filter (fun c -> c <> Nfa.Str.u_eos)
                          |> Seq.map (fun c -> if c = Nfa.Str.u_null then '0' else c)
                          |> String.of_seq)
                   end
                   | `Str ->
                     `Str
                       (v
                        |> List.rev
                        |> List.to_seq
                        |> Seq.filter (fun c -> c <> Nfa.Str.u_eos)
                        |> Seq.map (fun c -> if c = Nfa.Str.u_null then '0' else c)
                        |> String.of_seq))
                 (model ())
             in
             let env_model =
               Map.filter_mapi
                 ~f:(fun ~key ~data ->
                   let ( let* ) = Option.bind in
                   let rec aux = function
                     | Ast.Eia.Mul ls ->
                       let* ls = Base.Option.all (List.map aux ls) in
                       Option.some (List.fold_left Z.(mul) Z.one ls)
                     | Ast.Eia.Add ls ->
                       let* ls = Base.Option.all (List.map aux ls) in
                       Option.some (List.fold_left Z.( + ) Z.zero ls)
                     | Ast.Eia.Atom (Ast.Const v) -> Option.some v
                     | Ast.Eia.Atom (Ast.Var v) -> begin
                       match Map.find main_model (Ir.var v) with
                       | Some (`Int v) -> Option.some v
                       | Some (`Str _) | None -> None
                     end
                     | Ast.Eia.Pow (lhs, rhs) ->
                       let* lhs = aux lhs in
                       let* rhs = aux rhs in
                       Option.some (Utils.powz ~base:lhs rhs)
                     | _ -> None
                   in
                   begin
                     match aux data with
                     | Some v -> Option.some (`Int v)
                     | None ->
                       Format.printf
                         "Warning: some of the model pieces are likely to be missed: %s \
                          = %a\n\
                          %!"
                         key
                         Ast.pp_term_smtlib2
                         data;
                       None
                   end)
                 env
               |> Map.map_keys_exn ~f:(fun v -> Ir.var v)
             in
             Map.merge_disjoint_exn main_model env_model |> filter_internal)
       | `Unsat -> `Unsat
       | `Unknown -> `Unknown ir)
    | `Sat (_, env) -> `Sat (fun _ -> Map.empty)
    | `Unsat -> `Unsat
  end
;;
