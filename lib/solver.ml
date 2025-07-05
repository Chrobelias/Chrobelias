(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Set = Base.Set.Poly
module Map = Base.Map.Poly

type t = { vars : (Ir.atom, int) Map.t }

(*let pow base n = List.init n (Fun.const base) |> List.fold_left ( * ) 1*)
let internal_counter = ref 0

let internal s =
  internal_counter := !internal_counter + 1;
  !internal_counter + (s.vars |> Map.data |> List.fold_left Int.max 0)
;;

let collect_vars ir =
  Ir.fold
    (fun acc -> function
       (*| Ir.Exists (atoms, _) -> Set.union acc (Set.of_list atoms)*)
       | Ir.Reg (_, atoms) -> Set.union acc (atoms |> Set.of_list)
       | Ir.Rel (_, term, _) ->
         Set.union
           acc
           (Map.keys term
            |> List.concat_map (function
              | Ir.Var _ as ir -> [ ir ]
              | Ir.Pow2 a as ir -> [ ir; Ir.var a ]
              | Ir.Internal _ as ir -> [ ir ])
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
       | Ir.Reg (_, atoms) -> Set.union acc (atoms |> Set.of_list)
       | Ir.Exists (xs, _) -> Set.diff acc (Set.of_list xs)
       | _ -> acc)
    Set.empty
    ir
;;

let powerset term =
  let rec helper = function
    | [] -> []
    | [ x ] -> [ 0, [ 0 ]; 1, [ x ] ]
    | hd :: tl ->
      let open Base.List.Let_syntax in
      let ( let* ) = ( >>= ) in
      let* n, thing = helper tl in
      [ n, 0 :: thing; n + Int.shift_left 1 (List.length thing), hd :: thing ]
  in
  term
  |> List.map snd
  |> helper
  |> List.map (fun (a, x) -> a, Base.List.sum (module Base.Int) ~f:Fun.id x)
;;

let rec gcd a b =
  if a < 0 || b < 0 then gcd (abs a) (abs b) else if b = 0 then a else gcd b (a mod b)
;;

let div a b = if a mod b >= 0 then a / b else (a / b) - 1

let eval_rel vars rel term c =
  let term =
    Map.map_keys_exn ~f:(Map.find_exn vars) term
    |> Map.to_alist
    |> List.filter (fun (_, v) -> v <> 0)
  in
  let gcd = List.fold_left (fun acc (_, data) -> gcd data acc) 0 term in
  if gcd = 0
  then
    if
      match rel with
      | Ir.Eq -> 0 = c
      | Ir.Leq -> 0 <= c
    then NfaCollection.Msb.n ()
    else NfaCollection.Msb.z ()
  else (
    let thing = powerset term in
    (* Debug.printfln "IR %a" Ir.Eia ir;*)
    Debug.printfln
      "thing:[%a]"
      (Format.pp_print_list
         ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ")
         (fun fmt (b, c) -> Format.fprintf fmt "(%d, %d)" b c))
      thing;
    let states = ref Set.empty in
    let transitions = ref [] in
    let rec lp front =
      match front with
      | [] -> ()
      | hd :: tl ->
        if Set.mem !states hd
        then lp tl
        else begin
          let t =
            match rel with
            | Eq ->
              thing
              |> List.filter (fun (_, sum) -> (hd - sum) mod (2 * gcd) = 0)
              |> List.map (fun (bits, sum) -> div (hd - sum) 2, bits, hd)
            | Leq ->
              thing
              |> List.map (fun (bits, sum) -> gcd * div (hd - sum) (2 * gcd), bits, hd)
          in
          Debug.printfln
            "hd:%d, t:[%a]"
            hd
            (Format.pp_print_list
               ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ")
               (fun fmt (a, b, c) -> Format.fprintf fmt "(%d, %d, %d)" a b c))
            t;
          states := Set.add !states hd;
          transitions := t @ !transitions;
          lp (List.map (fun (x, _, _) -> x) t @ tl)
        end
    in
    lp [ c ];
    let states = Set.to_list !states in
    Debug.printfln
      "states:[%a]"
      (Format.pp_print_list
         ~pp_sep:(fun fmt () -> Format.fprintf fmt "; ")
         (fun fmt a -> Format.fprintf fmt "%d" a))
      states;
    let start = List.length states in
    let states = states |> List.mapi (fun i x -> x, i) |> Map.of_alist_exn in
    let idx c = Map.find states c |> Option.get in
    let transitions = List.map (fun (a, b, c) -> idx a, b, idx c) !transitions in
    let transitions =
      (match rel with
       | Eq ->
         thing
         |> List.filter_map (fun (d, sum) ->
           match Map.find states (-sum) with
           | None -> None
           | Some v -> Some (start, d, v))
       | Leq ->
         thing
         |> List.concat_map (fun (d, sum) ->
           Map.to_alist states
           |> List.filter_map (fun (v, idv) ->
             if -sum <= v then Some (start, d, idv) else None)))
      @ transitions
    in
    Nfa.Msb.create_nfa
      ~transitions
      ~start:[ start ]
      ~final:
        (match rel with
         | Eq -> [ idx c ]
         | Leq -> states |> Map.filter_keys ~f:(fun x -> x <= c) |> Map.data)
      ~vars:(List.map fst term)
      ~deg:(1 + List.fold_left Int.max 0 (List.map fst term))
    |> fun x ->
    Debug.dump_nfa
      ~msg:"Build (L)Eq Nfa: %s"
      ~vars:(Map.to_alist vars)
      Nfa.Msb.format_nfa
      x;
    x)
;;

let ( -- ) i j =
  let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
  aux j []
;;

let eval_reg vars reg atoms =
  let nfa = reg |> Regex.to_nfa in
  let reenum =
    0 -- (List.length atoms - 1)
    |> Map.of_list_with_key_exn ~get_key:Fun.id
    |> Map.map_keys_exn ~f:(fun k -> Map.find_exn vars (List.nth atoms k))
  in
  Nfa.Msb.reenumerate reenum nfa
;;

type bound =
  | EqConst of Ir.atom * int
  | LeqConst of (Ir.atom, int) Map.t * int
  | EqVar of Ir.atom * Ir.atom

let trivial ir =
  let rec infer_bounds : Ir.t -> _ = function
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
  in
  let simpl ir =
    ir
    |> Ir.map (function
      | Ir.Rel (Ir.Eq, term, 0) when Map.for_all ~f:(fun v -> Int.equal v 0) term ->
        Ir.true_
      | Ir.Rel (Ir.Leq, term, c) when Map.length term = 0 && c >= 0 -> Ir.true_
      | Ir.Rel (Ir.Leq, term, c) when Map.length term = 0 && c < 0 -> Ir.false_
      | ir -> ir)
    |> Ir.map (function
      | Ir.Lor [] -> Ir.false_
      | Ir.Land [] -> Ir.true_
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
  in
  let aux ir =
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
  in
  let rec aux2 ir =
    let ir' = aux ir in
    if Ir.equal ir ir' then ir' else aux2 ir'
  in
  aux2 ir
;;

let eval ir =
  let module Nfa = Nfa.Msb in
  let module NfaCollection = NfaCollection.Msb in
  let ir = trivial ir in
  Debug.printfln "Trivial solution %a\n" Ir.pp ir;
  let vars = collect_vars ir in
  let rec eval ir =
    Format.printf "%a\n%!" Ir.pp ir;
    match ir with
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
             Format.printf "Nfa for %a has %d nodes\n%!" Ir.pp ir (Nfa.length nfa);
             nfa)
          irs
        |> List.sort (fun nfa1 nfa2 -> Nfa.length nfa2 - Nfa.length nfa1)
      in
      let rec eval_and = function
        | hd :: [] -> hd
        | hd :: hd' :: tl ->
          Format.printf "Intersecting %d %d\n%!" (Nfa.length hd) (Nfa.length hd');
          let nfa = Nfa.intersect hd hd' in
          Debug.dump_nfa Nfa.format_nfa nfa;
          let nfas =
            nfa :: tl |> List.sort (fun nfa1 nfa2 -> Nfa.length nfa2 - Nfa.length nfa1)
          in
          eval_and nfas
        | [] -> failwith ""
      in
      eval_and nfas
    | Ir.Lor (hd :: tl) ->
      List.fold_left (fun nfa ir -> eval ir |> Nfa.unite nfa) (eval hd) tl
    | Ir.Rel (rel, term, c) -> eval_rel vars rel term c
    | Ir.Reg (reg, atoms) -> eval_reg vars reg atoms
    | Ir.Exists (atoms, ir) ->
      eval ir |> Nfa.project (List.filter_map (Map.find vars) atoms) |> Nfa.minimize
    | _ -> Format.asprintf "Unsupported IR %a to evaluate to" Ir.pp ir |> failwith
  in
  eval ir
  |> fun x ->
  Debug.dump_nfa ~msg:"evaluating %s" Nfa.format_nfa x;
  x, vars
;;

let dump f =
  let module Nfa = Nfa.Msb in
  let nfa, _ = eval f in
  Format.asprintf "%a" Nfa.format_nfa (nfa |> Nfa.minimize)
;;

let is_exp = function
  | Ir.Pow2 _ -> true
  | Ir.Var _ | Ir.Internal _ -> false
;;

let log2 n =
  let rec helper acc = function
    | 0 -> acc
    | n -> helper (acc + 1) (n / 2)
  in
  helper (-1) n
;;

let pow2 n = List.init n (Fun.const 2) |> List.fold_left ( * ) 1

let gen_list_n n =
  let rec helper acc = function
    | 0 -> [ 0 ]
    | n -> helper (n :: acc) (n - 1)
  in
  helper [] n |> List.rev
;;

let get_exp = function
  | Ir.Pow2 var -> Ir.var var
  | Ir.Var _ | Ir.Internal _ -> failwith "Expected exponent, found var"
;;

let to_exp = function
  | Ir.Pow2 _ -> failwith "Expected var"
  | Ir.Var var | Ir.Internal var -> Ir.pow2 var
;;

let decide_order vars =
  let rec perms list =
    let a =
      if List.length list <> 0
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
  let module Nfa = Nfa.MsbNat in
  let module NfaCollection = NfaCollection.MsbNat in
  chrob
  |> List.map (fun (a, c) ->
    let old_internal_counter = !internal_counter in
    let a_var = internal s in
    let var2_plus_a = internal s in
    let t = internal s in
    let c_mul_t = internal s in
    Debug.printfln "nfa_for_exponent2: internal_counter=%d" !internal_counter;
    Debug.printfln "[ var2_plus_a; c_mul_t; t ] = [%d; %d; %d]" var2_plus_a c_mul_t t;
    let nfa =
      Nfa.project
        [ var2_plus_a; c_mul_t; t; a_var ]
        (Nfa.intersect
           (NfaCollection.add ~lhs:var2_plus_a ~rhs:c_mul_t ~res:var)
           (Nfa.intersect
              (Nfa.intersect
                 (NfaCollection.add ~res:var2_plus_a ~lhs:var2 ~rhs:a_var)
                 (NfaCollection.eq_const a_var a))
              (NfaCollection.mul ~res:c_mul_t ~lhs:c ~rhs:t)))
    in
    Debug.dump_nfa ~msg:"nfa_for_exponent2 output nfa: %s" Nfa.format_nfa nfa;
    internal_counter := old_internal_counter;
    nfa)
;;

let nfa_for_exponent s var newvar chrob =
  let module Nfa = Nfa.MsbNat in
  let module NfaCollection = NfaCollection.MsbNat in
  chrob
  |> List.concat_map (fun (a, c) ->
    if c = 0
    then
      List.init (a + 10) (( + ) a)
      |> List.map (fun x ->
        let log = log2 x in
        x - log, log, 0)
      |> List.filter (fun (t, _, _) -> t = a)
    else c |> gen_list_n |> List.map (fun d -> a, d, c))
  |> List.map (fun (a, d, c) ->
    let old_internal_counter = !internal_counter in
    let a_plus_d = internal s in
    let t = internal s in
    let c_mul_t = internal s in
    let internal = internal s in
    let nfa =
      Nfa.project
        [ a_plus_d; c_mul_t; t ]
        (Nfa.intersect
           (NfaCollection.add ~lhs:a_plus_d ~rhs:c_mul_t ~res:var)
           (Nfa.intersect
              (NfaCollection.eq_const a_plus_d (a + d))
              (NfaCollection.mul ~res:c_mul_t ~lhs:c ~rhs:t)))
    in
    let n =
      List.init (a + 2) (( + ) a) |> List.filter (fun x -> x - log2 x >= a) |> List.hd
    in
    let newvar_nfa = NfaCollection.torename newvar d c in
    let geq_nfa =
      NfaCollection.geq var internal |> Nfa.intersect (NfaCollection.eq_const internal n)
    in
    let nfa =
      nfa
      |> Nfa.intersect newvar_nfa
      |> Nfa.minimize
      |> Nfa.intersect geq_nfa
      |> Nfa.project [ internal ]
    in
    internal_counter := old_internal_counter;
    nfa)
;;

(*
   let rec remove_leading_quantifiers = function
  | Ast.Exists (_, f) -> remove_leading_quantifiers f
  | _ as f -> f
;;

let%expect_test "Basic remove leading quantifiers" =
  {|ExEyEz z = 15|}
  |> Parser.parse_formula
  |> Result.get_ok
  |> remove_leading_quantifiers
  |> Format.printf "%a" Ast.pp_formula;
  [%expect {| (z = 15) |}]
;;

let%expect_test "Useless quantifier remove" =
  {|z = 15|}
  |> Parser.parse_formula
  |> Result.get_ok
  |> remove_leading_quantifiers
  |> Format.printf "%a" Ast.pp_formula;
  [%expect {| (z = 15) |}]
;;
*)

let project_exp s nfa x next =
  let module Nfa = Nfa.MsbNat in
  let module NfaCollection = NfaCollection.MsbNat in
  Debug.dump_nfa ~msg:"Nfa inside project_exp: %s" Nfa.format_nfa nfa;
  let get_deg = Map.find_exn s.vars in
  let x' = get_exp x in
  if is_exp next
  then
    nfa
    |> Nfa.get_chrobaks_sub_nfas
         ~res:(get_deg x)
         ~temp:(get_deg next)
         ~vars:(Map.data s.vars)
    |> List.to_seq
    |> Seq.flat_map (fun (nfa, chrobak, model_part) ->
      (let y = get_exp next in
       Debug.dump_nfa
         ~msg:"close to nfa_for_exponent2 - intersection nfa: %s"
         Nfa.format_nfa
         nfa;
       nfa_for_exponent2 s (get_deg x') (get_deg y) chrobak)
      |> List.map (Nfa.intersect nfa)
      |> List.map (fun nfa -> nfa, model_part)
      |> List.to_seq)
  else (
    let old_counter = !internal_counter in
    let inter = internal s in
    let nfa = nfa |> Nfa.intersect (NfaCollection.torename2 (get_deg x') inter) in
    Debug.dump_nfa ~msg:"Nfa intersected with torename2: %s" Nfa.format_nfa nfa;
    let ans =
      nfa
      |> Nfa.get_chrobaks_sub_nfas ~res:(get_deg x) ~temp:inter ~vars:(Map.data s.vars)
      |> List.to_seq
      |> Seq.flat_map (fun (nfa, chrobak, model_part) ->
        nfa_for_exponent s (get_deg x') inter chrobak
        |> List.map (Nfa.intersect nfa)
        |> List.map (fun nfa -> nfa, model_part)
        |> List.to_seq)
      |> Seq.map (fun (nfa, model_part) -> Nfa.project [ inter ] nfa, model_part)
    in
    internal_counter := old_counter;
    ans)
;;

let proof_order return project s nfa order =
  let module Nfa = Nfa.MsbNat in
  let module NfaCollection = NfaCollection.MsbNat in
  let get_deg = Map.find_exn s.vars in
  let rec helper nfa order model =
    Debug.dump_nfa ~msg:"Nfa inside proof_order: %s" Nfa.format_nfa nfa;
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
            (NfaCollection.eq_const (get_deg x) 1)
            (NfaCollection.eq_const (get_deg x') 0)
          |> Nfa.truncate deg
          |> Nfa.intersect nfa
          |> project (get_deg x)
        in
        Debug.printf "Zero nfa for %a: " Ir.pp_atom x;
        Debug.dump_nfa ~msg:"%s" Nfa.format_nfa zero_nfa;
        match helper zero_nfa tl model with
        | Some _ as res -> res
        | None ->
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
             let term = [ x, 1; y, -1 ] |> Map.of_alist_exn in
             Ir.geq term 0)
           |> List.of_seq
           |> function
           | [] -> failwith ""
           | comps -> Ir.land_ comps)
      in
      let order_nfa =
        order_nfa
        |> Nfa.to_nat
        |> Nfa.MsbNat.reenumerate
             (order_vars |> Map.map_keys_exn ~f:(fun k -> Map.find_exn s.vars k))
      in
      Nfa.MsbNat.intersect nfa order_nfa |> Nfa.MsbNat.minimize)
  in
  Debug.dump_nfa ~msg:"NFA taking order into account: %s" Nfa.MsbNat.format_nfa nfa;
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
  let nfa = Nfa.Msb.minimize nfa in
  Debug.dump_nfa
    ~msg:"Minimized raw original nfa: %s"
    ~vars:(Map.to_alist vars)
    Nfa.Msb.format_nfa
    nfa;
  let nfa =
    Map.fold
      ~init:nfa
      ~f:(fun ~key:k ~data:v acc ->
        if is_exp k then Nfa.Msb.intersect acc (NfaCollection.Msb.power_of_two v) else acc)
      vars
  in
  Debug.dump_nfa
    ~msg:"Minimized raw2 original nfa: %s"
    ~vars:(Map.to_alist vars)
    Nfa.Msb.format_nfa
    nfa;
  let nfa =
    Map.fold
      ~f:(fun ~key:k ~data:v acc ->
        if is_exp k
        then acc
        else if Map.mem vars (to_exp k) |> not
        then Nfa.Msb.project [ v ] acc
        else acc)
      ~init:nfa
      vars
  in
  Debug.dump_nfa
    ~msg:"Minimized raw3 original nfa: %s"
    ~vars:(Map.to_alist vars)
    Nfa.Msb.format_nfa
    nfa;
  let nfa = nfa |> Nfa.to_nat |> Nfa.MsbNat.minimize in
  Debug.dump_nfa
    ~msg:"Minimized original nfa: %s"
    ~vars:(Map.to_alist vars)
    Nfa.MsbNat.format_nfa
    nfa;
  let powered_vars =
    Map.filteri ~f:(fun ~key:k ~data:_ -> is_exp k || Map.mem vars (to_exp k)) vars
  in
  let s = { vars = powered_vars } in
  decide_order powered_vars
  |> List.to_seq
  |> Seq.map (prepare_order s nfa)
  |> Seq.filter (function order, nfa ->
      let nfa =
        nfa |> Nfa.MsbNat.project (order |> List.map (fun str -> Map.find_exn s.vars str))
      in
      Debug.dump_nfa ~msg:"Checking if solvable: %s" Nfa.MsbNat.format_nfa nfa;
      nfa |> Nfa.MsbNat.run)
  |> Seq.map (fun (order, nfa) -> proof_order return next s nfa order)
  |> Seq.find (function
    | Some _ -> true
    | None -> false)
  |> function
  | Some x -> x
  | None -> None
;;

let proof_semenov f =
  Debug.printf "Testing2 %a" Ir.pp f;
  match
    f
    |> eval_semenov
         (fun _ nfa _ -> if Nfa.MsbNat.run nfa then Some () else None)
         (fun x nfa -> Nfa.MsbNat.project [ x ] nfa)
  with
  | Some _ -> `Sat
  | None -> `Unsat
;;

let get_model_normal f =
  let nfa, vars = f |> eval in
  let free_vars = f |> collect_free |> Set.to_list in
  Nfa.Msb.any_path nfa (List.map (fun v -> Map.find_exn vars v) free_vars)
  |> Option.map (fun (model, _) ->
    model |> List.mapi (fun i v -> List.nth free_vars i, v) |> Map.of_alist_exn)
;;

let get_model_semenov f =
  let res =
    f
    |> eval_semenov
         (fun s nfa model ->
            match Nfa.MsbNat.any_path nfa (Map.data s.vars) with
            | Some path -> Some (s, path, model)
            | None -> None)
         (fun _ nfa -> nfa)
  in
  match res with
  | Some (s, model, models) ->
    let rec thing = function
      | [] -> failwith "unreachable"
      | [ (model, _) ] -> model
      | (model, len1) :: (model2, len2) :: tl ->
        ( Base.List.zip_exn model model2
          |> List.map (fun (x, y) ->
            Debug.printfln "x=%d,y=%d,len1=%d,len2=%d" x y len1 len2;
            (y * pow2 len1) + x)
        , len1 + len2 )
        :: tl
        |> thing
    in
    let map =
      thing (model :: models)
      |> List.mapi (fun i v -> List.nth (Map.keys s.vars) i, v)
      |> Map.of_alist_exn
    in
    let map = Map.filter_keys map ~f:(fun key -> not (is_exp key)) in
    let f =
      f
      |> Ir.map (function
        | Ir.Rel (rel, term, c) ->
          let filter =
            fun k ->
            match k with
            | Ir.Pow2 _ -> true
            | Ir.Var _ -> Map.mem map k
            | Ir.Internal _ -> failwith "Unexpected"
          in
          let c =
            term
            |> Map.filter_keys ~f:filter
            |> Map.to_sequence
            |> Base.Sequence.map ~f:(fun (k, v) ->
              v
              *
                match k with
                | Ir.Pow2 x -> pow2 (Map.find_exn map (Var x))
                | Ir.Var _ -> Map.find_exn map k
                | Ir.Internal _ -> failwith "Unexpected")
            |> Base.Sequence.fold ~init:c ~f:( + )
          in
          let term = term |> Map.filter_keys ~f:(Fun.negate filter) in
          Ir.rel rel term c
        (* | Ast.Var x -> *)
        (*   Base.Option.value ~default:(Ast.Var x) (Map.find map x |> Option.map Ast.const) *)
        (* | Ast.Pow (2, Ast.Const c) -> Ast.Const (pow2 c) *)
        (* | Ast.Pow _ as t -> failwith (Format.asprintf "unimplemented: %a" Ast.pp_term t) *)
        | x -> x)
    in
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
    (*let free_vars = collect_free ir in*)
    (*let ir = Ir.exists (free_vars |> Set.to_list) ir in*)
    Debug.printf "Testing %a" Ir.pp ir;
    let nfa, _ = ir |> eval in
    Debug.dump_nfa ~msg:"resulting nfa: %s" Nfa.Msb.format_nfa nfa;
    if Nfa.Msb.run nfa then `Sat else `Unsat)
;;

let get_model f =
  let run_semenov = collect_vars f |> Map.keys |> List.exists is_exp in
  if run_semenov then get_model_semenov f else get_model_normal f
;;

(*
   let%expect_test "Proof any x > 7 can be represented as a linear combination of 3 and 5" =
  Format.printf
    "%b"
    ({|AxEyEz x = 3*y + 5*z | x <= 7|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Disproof any x > 6 can be represented as a linear combination of 3 and 5"
  =
  Format.printf
    "%b"
    ({|AxEyEz x = 3*y + 5*z | x <= 6|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof
     |> Result.get_ok);
  [%expect {| false |}]
;;

let%expect_test "Proof for all x exists x + 1" =
  Format.printf
    "%b"
    ({|AxEy y = x + 1|} |> Parser.parse_formula |> Result.get_ok |> proof |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Disproof for all x exists x - 1" =
  Format.printf
    "%b"
    ({|AxEy x = y + 1|} |> Parser.parse_formula |> Result.get_ok |> proof |> Result.get_ok);
  [%expect {| false |}]
;;

let%expect_test "Proof simple existential formula" =
  Format.printf
    "%b"
    ({|ExEy 15 = x + y & y <= 10|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Proof simple any quantified formula" =
  Format.printf
    "%b"
    ({|Ax x = 2 | ~(x = 2)|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Proof 2 <= 3" =
  Format.printf
    "%b"
    ({|2 <= 3|} |> Parser.parse_formula |> Result.get_ok |> proof |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Proof zero is the least" =
  Format.printf
    "%b"
    ({|Ax x >= 0|} |> Parser.parse_formula |> Result.get_ok |> proof |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Disproof 3 >= 15" =
  Format.printf
    "%b"
    ({|3 >= 15|} |> Parser.parse_formula |> Result.get_ok |> proof |> Result.get_ok);
  [%expect {| false |}]
;;

let%expect_test "Proof less than 1 is zero" =
  Format.printf
    "%b"
    ({|Ax x < 1 -> x = 0|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Proof if x > 3 and y > 4 then x + y > 7" =
  Format.printf
    "%b"
    ({|AxAy x > 3 & y > 4 -> x + y > 7|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Proof two is even" =
  s := default_s ();
  {|Ey x = 2*y|}
  |> Parser.parse_formula
  |> Result.get_ok
  |> pred "even" [ "x" ]
  |> Result.get_ok;
  Format.printf
    "%b"
    ({|even(2)|} |> Parser.parse_formula |> Result.get_ok |> proof |> Result.get_ok);
  s := default_s ();
  [%expect {| true |}]
;;

let%expect_test "Proof three is odd" =
  s := default_s ();
  {|Ey x = 2*y|}
  |> Parser.parse_formula
  |> Result.get_ok
  |> pred "even" [ "x" ]
  |> Result.get_ok;
  Format.printf
    "%b"
    ({|even(3)|} |> Parser.parse_formula |> Result.get_ok |> proof |> Result.get_ok);
  s := default_s ();
  [%expect {| false |}]
;;

let%expect_test "Proof sum of two even is even" =
  s := default_s ();
  {|Ey x = 2*y|}
  |> Parser.parse_formula
  |> Result.get_ok
  |> pred "even" [ "x" ]
  |> Result.get_ok;
  Format.printf
    "%b"
    ({|AxAyAz x + y = z & even(x) & even(y) -> even(z)|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof
     |> Result.get_ok);
  s := default_s ();
  [%expect {| true |}]
;;

let%expect_test "Proof sum of two even plus one is odd" =
  s := default_s ();
  {|Ey x = 2*y|}
  |> Parser.parse_formula
  |> Result.get_ok
  |> pred "even" [ "x" ]
  |> Result.get_ok;
  Format.printf
    "%b"
    ({|AxAyAz x + y = z & even(x) & even(y) -> ~even(z + 1)|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof
     |> Result.get_ok);
  s := default_s ();
  [%expect {| true |}]
;;

let%expect_test "Disproof sum of two even plus one is even" =
  s := default_s ();
  {|Ey x = 2*y|}
  |> Parser.parse_formula
  |> Result.get_ok
  |> pred "even" [ "x" ]
  |> Result.get_ok;
  Format.printf
    "%b"
    ({|AxAyAz x + y = z & even(x) & even(y) -> even(z + 1)|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof
     |> Result.get_ok);
  s := default_s ();
  [%expect {| false |}]
;;

let%expect_test "Proof a number is even iff it's not odd" =
  s := default_s ();
  {|Ey x = 2*y|}
  |> Parser.parse_formula
  |> Result.get_ok
  |> pred "even" [ "x" ]
  |> Result.get_ok;
  {|Ey x = 2*y + 1|}
  |> Parser.parse_formula
  |> Result.get_ok
  |> pred "odd" [ "x" ]
  |> Result.get_ok;
  Format.printf
    "%b"
    ({|Ax (even(x) -> ~odd(x)) & (~odd(x) -> even(x))|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof
     |> Result.get_ok);
  s := default_s ();
  [%expect {| true |}]
;;

let%expect_test "Get a model for x = 3 & y = 7" =
  s := default_s ();
  let model =
    {|x = 3 & y = 7|}
    |> Parser.parse_formula
    |> Result.get_ok
    |> get_model
    |> Result.get_ok
    |> Option.get
  in
  Map.iteri ~f:(fun ~key:k ~data:v -> Format.printf "%s = %d  " k v) model;
  s := default_s ();
  [%expect {| x = 3  y = 7 |}]
;;

let%expect_test "Get a model for Ey x = 7*y & x > 9 & x < 20" =
  s := default_s ();
  let model =
    {|Ey x = 7*y & x > 9 & x < 20|}
    |> Parser.parse_formula
    |> Result.get_ok
    |> get_model
    |> Result.get_ok
    |> Option.get
  in
  Map.iteri ~f:(fun ~key:k ~data:v -> Format.printf "%s = %d  " k v) model;
  s := default_s ();
  [%expect {| x = 14 |}]
;;

let%expect_test "Disproof 2**x equals to 0" =
  Format.printf
    "%b"
    ({|2**x = 0|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| false |}]
;;

let%expect_test "Proof 2**x equals to 1 if x = 0" =
  Format.printf
    "%b"
    ({|2**x = 1|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Disproof 2**x + 2**y could be less than 2" =
  Format.printf
    "%b"
    ({|2**x + 2**y < 2|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| false |}]
;;

let%expect_test "Proof 2**x + 2**y could be less than 3" =
  Format.printf
    "%b"
    ({|2**x + 2**y < 3|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Proof 2**x equals to 2**x" =
  Format.printf
    "%b"
    ({|2**x = 2**x|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Proof 2**x equals to 2**y" =
  Format.printf
    "%b"
    ({|2**x = 2**y|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Disproof 2**x equals to x" =
  Format.printf
    "%b"
    ({|2**x = x|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| false |}]
;;

let%expect_test "Proof 2**x equals to x + 1 with x = 1" =
  Format.printf
    "%b"
    ({|2**x = x + 1|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Proof 2**x equals to x + 2 with x = 2" =
  Format.printf
    "%b"
    ({|2**x = x + 2|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Disproof 2**x equals to x + 3" =
  Format.printf
    "%b"
    ({|2**x = x + 3|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| false |}]
;;

let%expect_test "Proof 2**x can be equal to 2**y + 1" =
  Format.printf
    "%b"
    ({|2**x = 2**y + 1|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Proof 2**x can be equal to 2**y + 2" =
  Format.printf
    "%b"
    ({|2**x = 2**y + 2|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Disproof 2**x can be equal to 2**y + 5" =
  Format.printf
    "%b"
    ({|2**x = 2**y + 5|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| false |}]
;;

let%expect_test "Proof 2**x can be equal to 2**y + 2**z + 7" =
  Format.printf
    "%b"
    ({|2**x = 2**y + 2**z + 7|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Proof exists even 2**x" =
  s := default_s ();
  {|Ey x = 2*y|}
  |> Parser.parse_formula
  |> Result.get_ok
  |> pred "even" [ "x" ]
  |> Result.get_ok;
  Format.printf
    "%b"
    ({|even(2**x)|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  s := default_s ();
  [%expect {| true |}]
;;

let%expect_test "Proof exists odd (not even) 2**x" =
  s := default_s ();
  {|Ey x = 2*y|}
  |> Parser.parse_formula
  |> Result.get_ok
  |> pred "even" [ "x" ]
  |> Result.get_ok;
  Format.printf
    "%b"
    ({|~even(2**x)|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  s := default_s ();
  [%expect {| true |}]
;;

let%expect_test "Proof not exists odd 2**x having x > 0" =
  s := default_s ();
  {|Ey x = 2*y|}
  |> Parser.parse_formula
  |> Result.get_ok
  |> pred "even" [ "x" ]
  |> Result.get_ok;
  Format.printf
    "%b"
    ({|~even(2**x) & x > 0|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  s := default_s ();
  [%expect {| false |}]
;;

let%expect_test "Proof exists even 2**x + 1" =
  s := default_s ();
  {|Ey x = 2*y|}
  |> Parser.parse_formula
  |> Result.get_ok
  |> pred "even" [ "x" ]
  |> Result.get_ok;
  Format.printf
    "%b"
    ({|even(2**x + 1)|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  s := default_s ();
  [%expect {| true |}]
;;

let%expect_test "Proof not exists even 2**x + 1 for x > 0" =
  s := default_s ();
  {|Ey x = 2*y|}
  |> Parser.parse_formula
  |> Result.get_ok
  |> pred "even" [ "x" ]
  |> Result.get_ok;
  Format.printf
    "%b"
    ({|even(2**x + 1) & x > 0|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  s := default_s ();
  [%expect {| false |}]
;;

let%expect_test "Proof exists an even 2**x" =
  s := default_s ();
  {|Ey x = 2*y|}
  |> Parser.parse_formula
  |> Result.get_ok
  |> pred "even" [ "x" ]
  |> Result.get_ok;
  Format.printf
    "%b"
    ({|even(2**x)|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  s := default_s ();
  [%expect {| true |}]
;;

let%expect_test "Disproof 2**x <= y & y < (2(2**x)) & 2**z <= 5y & 5y < (2(2**z)) & x = z"
  =
  Format.printf
    "%b"
    ({|2**x <= y & y < (2*(2**x)) & 2**z <= 5*y & 5*y < (2*(2**z)) & x = z|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| false |}]
;;

let%expect_test "Proof 2**x <= z & z < 2(2**x) & 60 <= z & z <= 100 & ~x = 6 & 5y = z" =
  Format.printf
    "%b"
    ({|2**x <= z & z < 2*(2**x) & 60 <= z & z <= 100 & ~x = 6 & 5*y = z|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test
    "Disproof 2**x <= z & z < 2*(2**x) & 61 <= z & z <= 100 & ~x = 6 & 5*y = z"
  =
  Format.printf
    "%b"
    ({|2**x <= z & z < 2*(2**x) & 61 <= z & z <= 100 & ~x = 6 & 5*y = z|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| false |}]
;;

let%expect_test "Disproof 2**x can be equal to 2**y + 5 using common proof" =
  Format.printf
    "%b"
    ({|2**x = 2**y + 5|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| false |}]
;;

let%expect_test "Proof 2**x can be equal to 2**y + 2**z + 7 using common proof" =
  Format.printf
    "%b"
    ({|2**x = 2**y + 2**z + 7|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof
     |> Result.get_ok);
  [%expect {| true |}]
;;

let%expect_test "Disproof quantified 2**x can be equal to 2**y + 5 using common proof" =
  Format.printf
    "%b"
    ({|ExEy 2**x = 2**y + 5|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof_semenov
     |> Result.get_ok);
  [%expect {| false |}]
;;

let%expect_test "Proof quantified 2**x can be equal to 2**y + 2**z + 7 using common proof"
  =
  Format.printf
    "%b"
    ({|ExEy 2**x = 2**y + 2**z + 7|}
     |> Parser.parse_formula
     |> Result.get_ok
     |> proof
     |> Result.get_ok);
  [%expect {| true |}]
;;
*)
