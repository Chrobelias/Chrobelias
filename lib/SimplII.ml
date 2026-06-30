(* SPDX-License-Identifier: MIT *)
(* Copyright 2026, RLIA[t]. *)
[@@@warning "+unused-value-declaration"]

let trace_log fmt = Debug.trace "simpl" fmt
let _config = Config.config
let _base = _config.enc_base

module NfaS = Nfa.Lsb (Nfa.Str)

type relop =
  | Leq
  | Eq

module type SYM0 = sig
  type term
  type str
  type ph

  include FT_SIG.z_term with type term := term
  include FT_SIG.str_term with type term := term and type str := str
  include FT_SIG.s_ph with type ph := ph and type term := term and type str := str

  val iofs : str -> term
  val exists : Ast.any_atom list -> ph -> ph
  val unsupp : string -> ph
end

module type SYM = sig
  include SYM0

  type repr

  val prj : ph -> repr [@@warning "-32"]
  val pp_str : Format.formatter -> term -> unit
  val const : int -> term
  val in_rei : term -> char list Regex.t -> ph
  val in_re_raw : str -> NfaS.t -> ph
  val in_re_rawi : term -> NfaS.t -> ph
end

module type SYM_SUGAR = sig
  include SYM
  include FT_SIG.s_extra with type ph := ph and type term := term
end

module type SYM_SUGAR_AST =
  SYM_SUGAR
  with type ph = Ast.t
   and type repr = Ast.t
   and type str = string Ast.RLia.term
   and type term = Z.t Ast.RLia.term

module Id_symantics :
  SYM
  with type ph = Ast.t
   and type repr = Ast.t
   and type term = Z.t Ast.RLia.term
   and type str = string Ast.RLia.term = struct
  type term = Z.t Ast.RLia.term
  type str = string Ast.RLia.term

  let pp_str = Ast.RLia.pp_term

  type ph = Ast.t
  type repr = Ast.t

  (** Terms *)
  let bw k a b =
    match k with
    | FT_SIG.Bwand -> Ast.RLia.bwand a b
    | FT_SIG.Bwor -> Ast.RLia.bwor a b
    | FT_SIG.Bwxor -> Ast.RLia.bwxor a b
  ;;

  include struct
    open Ast.RLia

    let in_re l regex = Ast.RLia (InRe (l, Ast.S, regex))
    let in_rei l regex = Ast.RLia (InRe (l, Ast.I, regex))
    let in_re_raw l regex = Ast.RLia (InReRaw (l, Ast.S, regex))
    let in_re_rawi l regex = Ast.RLia (InReRaw (l, Ast.I, regex))
    let iofs x = Iofs x
  end

  let mod_ = Ast.RLia.mod_
  let mul = Ast.RLia.mul
  let add = Ast.RLia.add
  let land_ xs = Ast.land_ xs
  let lor_ xs = Ast.lor_ xs
  let not = Ast.lnot
  let pred s = Ast.pred s
  let str_var s : str = Atom (Ast.Var (s, S))
  let str_const s : str = Ast.RLia.Str_const s
  let constz s = Ast.RLia.Const s
  let const s : term = constz (Z.of_int s)

  (* Formulas *)

  let var s = Ast.RLia.Atom (Ast.Var (s, I))
  let exists atoms ph = Ast.exists atoms ph
  let eqz l r = Ast.RLia (Ast.RLia.eq l r Ast.I)
  let neqz l r = Ast.RLia (Ast.RLia.neq l r Ast.I)
  let leq l r = Ast.RLia (Ast.RLia.leq l r)
  let lt l r = Ast.RLia (Ast.RLia.lt l r)
  let v e p = Ast.RLia (Ast.RLia.v e p)
  let true_ = Ast.true_
  let false_ = Ast.false_
  let prj = Fun.id
  let unsupp s = Ast.Unsupp s
end

let apply_term_symantics
      (type a b)
      (module S : SYM_SUGAR with type term = a and type str = b)
  =
  let rec helperT : Z.t Ast.RLia.term -> a = function
    | Ast.RLia.Const n -> S.constz n
    | Atom (Ast.Var (s, I)) -> S.var s
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    | Bwand (l, r) -> S.bw FT_SIG.Bwand (helperT l) (helperT r)
    | Bwor (l, r) -> S.bw FT_SIG.Bwor (helperT l) (helperT r)
    | Bwxor (l, r) -> S.bw FT_SIG.Bwxor (helperT l) (helperT r)
    | Mod (t, z) -> S.mod_ (helperT t) z
    | Iofs Ast.RLia.(Str_const s) ->
      (match int_of_string_opt s with
       | Some n -> S.constz (Z.of_int n)
       | None -> S.iofs (S.str_const s))
    | Iofs t -> S.iofs (helperS t)
    | rlia -> failwith (Format.asprintf "Not supported: %a" Ast.pp_term_smtlib2 rlia)
  and helperS : string Ast.RLia.term -> S.str = function
    | Str_const s -> S.str_const s
    | Atom (Ast.Var (s, _)) -> S.str_var s
    | rlia -> failwith (Format.asprintf "Not supported: %a" Ast.pp_term_smtlib2 rlia)
  in
  (fun x -> helperT x), fun y -> helperS y
;;

let apply_symantics (type a) (module S : SYM_SUGAR with type ph = a) =
  let helperT, helperS = apply_term_symantics (module S) in
  let rec helper = function
    | Ast.Land xs -> S.land_ (List.map helper xs)
    | Lor xs -> S.lor_ (List.map helper xs)
    | Lnot x -> S.not (helper x)
    | True -> S.true_
    | RLia e -> helper_rlia e
    | Pred s -> assert false
    | Exists (vs, ph) -> S.exists vs (helper ph)
    | Unsupp s -> S.unsupp s
  and helper_rlia rlia =
    match rlia with
    | Ast.RLia.Eq (l, r, I) -> S.(helperT l = helperT r)
    | Ast.RLia.Eq (l, r, S) -> failwith "unsupported string equalities"
    | Neq (l, r, I) -> S.(helperT l <> helperT r)
    | Ast.RLia.Neq (l, r, S) -> failwith "unsupported string dis-equalities"
    | Leq (l, r) -> S.(helperT l <= helperT r)
    | InRe (term, Ast.S, regex) -> S.in_re (helperS term) regex
    | InRe (term, Ast.I, regex) -> S.in_rei (helperT term) regex
    | InReRaw (term, Ast.S, regex) -> S.in_re_raw (helperS term) regex
    | InReRaw (term, Ast.I, regex) -> S.in_re_rawi (helperT term) regex
    | V (term, pow) -> S.v (helperT term) (helperT pow)
  in
  helper
;;

let apply_symantics_unsugared (type a) (module S : SYM with type ph = a) =
  let module M = struct
    include S
    include FT_SIG.Sugar (S)
  end
  in
  apply_symantics (module M)
;;

let make_main_symantics ?alpha ?agressive env =
  let _ : Env.t = env in
  let module Set = Base.Set.Poly in
  let module Main_symantics_ = struct
    open Ast
    include Id_symantics

    let compare_term = RLia.compare_term
    let constz c = Ast.RLia.Const c
    let const c = constz (Z.of_int c)

    let var s : term =
      match Env.lookup_int s env with
      | None ->
        begin match Env.lookup_string s env with
        | Some (Str_const c) ->
          begin match Id_symantics.constz (Z.of_string c) with
          | exception _ -> Id_symantics.constz Z.minus_one
          | v -> v
          end
        | _ -> RLia.Atom (Ast.Var (s, I))
        end
      | Some c ->
        (* log "Substuting %s ~~> %a" s Ast.pp_term_smtlib2 c; *)
        c
    ;;

    let str_var s : str =
      match Env.lookup_string s env with
      | Some c -> c
      | None -> RLia.Atom (Ast.Var (s, S))
    ;;

    let iofs = function
      | Ast.RLia.Str_const s ->
        begin match s with
        | "" -> Id_symantics.constz Z.minus_one
        | s when String.for_all Base.Char.is_digit s ->
          Id_symantics.constz (Z.of_string s)
        | _ -> Id_symantics.constz Z.minus_one
        end
      | s -> Id_symantics.iofs s
    ;;

    let collect_inside_mul xs =
      List.fold_right
        (fun x acc : term list ->
           match x, acc with
           | RLia.Mul ys, _ -> ys @ acc
           | e, RLia.Add ss :: tl | Add ss, e :: tl ->
             Add (List.map (fun x -> RLia.Mul [ x; e ]) ss) :: tl
           | x, _ -> x :: acc)
        xs
        []
    ;;

    let mul xs =
      let fold_and_sort init op xs =
        let c, xs =
          List.fold_left
            (fun (cacc, phacc) -> function
               | RLia.(Const c) -> op c cacc, phacc
               | ph -> cacc, ph :: phacc)
            (init, [])
            xs
        in
        c, List.sort compare_term xs
      in
      match fold_and_sort Z.one Z.( * ) (collect_inside_mul xs) with
      | c, _ when Z.(equal c zero) -> RLia.Const Z.zero
      | c, [] -> RLia.Const c
      | c, [ h ] when Z.equal c Z.one -> h
      | c, xs when Z.equal c Z.one -> Ast.RLia.mul (List.sort compare_term xs)
      | c, [ Add ss ] -> RLia.Add (List.map (fun x -> RLia.Mul [ constz c; x ]) ss)
      | c, xs -> Ast.RLia.mul (constz c :: List.sort compare_term xs)
    ;;

    let rec add xs =
      let collect_inside_add xs =
        let extend h tl =
          let rec loop c1 tl1 = function
            | ph :: ptl when ph = RLia.Mul tl1 ->
              if Z.(equal c1 minus_one)
              then ptl
              else RLia.Mul (RLia.Const Z.(one + c1) :: tl1) :: ptl
            | RLia.Mul (RLia.Const c2 :: tl2) :: ptl when Stdlib.(tl1 = tl2) ->
              if Z.(c1 + c2 = zero)
              then ptl
              else RLia.Mul (RLia.Const Z.(c1 + c2) :: tl1) :: ptl
            | ph :: ptl -> ph :: loop c1 tl1 ptl
            | [] -> [ h ]
          in
          match h with
          | RLia.Mul (RLia.Const c1 :: tl1) -> loop c1 tl1 tl
          | RLia.Mul tl1 -> loop Z.one tl1 tl
          | _ -> h :: tl
        in
        List.fold_right
          (fun x acc ->
             match x, acc with
             | RLia.Add ts, _ -> ts @ acc
             | Mul (Const c1 :: ph1), RLia.Mul (Const c2 :: ph2) :: tl
               when List.equal Ast.RLia.eq_term ph1 ph2 ->
               if Z.(c1 + c2 = zero) then tl else mul (Const Z.(c1 + c2) :: ph1) :: tl
             | Mul [ Const c1; ph1 ], ph2 :: tl when Ast.RLia.eq_term ph1 ph2 ->
               extend (mul [ Const Z.(of_int 1 + c1); ph1 ]) tl
             | a, _ -> extend a acc)
          xs
          []
      in
      let fold_and_sort init op xs =
        let c, xs =
          List.fold_left
            (fun (cacc, phacc) -> function
               | RLia.Const c -> op c cacc, phacc
               | ph -> cacc, ph :: phacc)
            (init, [])
            xs
        in
        c, List.sort compare_term xs
      in
      match fold_and_sort Z.zero Z.( + ) (collect_inside_add xs) with
      | c, [ RLia.Atom (Var (x, I)); Mul [ RLia.(Const x1); RLia.Atom (Var (x2, _)) ] ]
        when Z.(c = zero) && x = x2 && x1 = Z.minus_one -> const 0
      | c, Mul [ RLia.(Const c1); t1 ] :: Mul [ RLia.(Const c2); t2 ] :: tl
        when Stdlib.(t1 = t2) ->
        if c1 = Z.(minus_one * c2)
        then add (constz c :: tl)
        else add (constz c :: Mul [ RLia.Const Z.(c1 + c2); t1 ] :: tl)
      | c, [ h ] when Z.(equal c zero) -> h
      | c, [] when Z.(equal c zero) -> const 0
      | c, xs when Z.(equal c zero) ->
        let ans = Ast.RLia.add (List.sort compare_term xs) in
        ans
      | c, [] -> constz c
      | c, xs -> Ast.RLia.add (constz c :: List.sort compare_term xs)
    ;;

    let rec negate = function
      | RLia.Add xs -> add (List.map negate xs)
      | x -> mul [ const (-1); x ]
    ;;

    (** Formulas *)
    let exists var ph = Ast.exists var ph

    let true_ = Ast.true_
    let false_ = Ast.false_

    let rec not = function
      | Ast.RLia (Ast.RLia.Leq (lhs, rhs)) -> Ast.rlia (Ast.RLia.gt lhs rhs)
      | Ast.RLia (Ast.RLia.InReRaw (v, S, re)) when Option.is_some alpha ->
        Id_symantics.in_re_raw v (re |> NfaS.invert ?alpha)
      | Ast.RLia (Ast.RLia.InReRaw (v, I, re)) when Option.is_some alpha ->
        Id_symantics.in_re_rawi v (re |> NfaS.invert ?alpha)
      | Ast.RLia (Ast.RLia.InRe (v, kind, re)) when Option.is_some alpha ->
        Ast.rlia (Ast.RLia.inreraw v kind (NfaS.invert ?alpha (NfaS.of_regex re)))
      | Ast.RLia (Ast.RLia.Eq (lhs, rhs, I)) -> Id_symantics.neqz lhs rhs
      | Ast.RLia (Ast.RLia.Eq (lhs, rhs, S)) -> failwith "Unsupported string dis-equality"
      | Ast.Lnot x -> x
      | Land xs -> Ast.lor_ (List.map not xs)
      | Lor xs -> Ast.land_ (List.map not xs)
      | x -> Ast.lnot x
    ;;

    let land_ xs =
      let flat =
        List.concat_map
          (function
            | Ast.Land xs -> xs
            | x -> [ x ])
          xs
      in
      let compare_ast l r =
        match l, r with
        | Ast.True, Ast.True -> 0
        | True, _ -> -1
        | _, True -> 1
        | Lnot _, _ -> -1
        | _, Lnot _ -> 1
        | _ -> Ast.compare l r
      in
      let flat = Base.List.dedup_and_sort ~compare:compare_ast flat in
      match flat with
      | [] -> false_
      | Lnot True :: _ -> false_
      | [ h ] -> h
      | _ ->
        (match List.drop_while (( = ) Ast.True) flat with
         | [] -> true_
         | xs -> Ast.land_ xs)
    ;;

    let lor_ xs =
      let flat =
        List.concat_map
          (function
            | Ast.Lor xs -> xs
            | x -> [ x ])
          xs
      in
      let compare_ast l r =
        match l, r with
        | Ast.True, Ast.True -> 0
        | True, _ -> -1
        | _, True -> 1
        | Lnot _, _ -> -1
        | _, Lnot _ -> 1
        | _ -> Ast.compare l r
      in
      let flat = Base.List.dedup_and_sort ~compare:compare_ast flat in
      match flat with
      | [] -> Id_symantics.true_
      | [ h ] -> h
      | True :: _ -> Id_symantics.true_
      | xs -> Ast.lor_ xs
    ;;

    let relop op l r =
      let ofop =
        match op with
        | Leq -> fun x y -> RLia (RLia.leq x y)
        | Eq -> fun x y -> RLia (RLia.eq x y I)
      in
      match l, r with
      | RLia.(Const l), RLia.(Const r) ->
        (match op with
         | Eq when Z.equal l r -> true_
         | Eq -> false_
         | Leq when l <= r -> true_
         | Leq -> false_)
      | RLia.(Add (Atom (Var (v1, _)) :: Mul [ Const c; Atom (Var (v2, _)) ] :: tl)), rhs
        when String.equal v1 v2 && c = Z.minus_one -> ofop (RLia.Add tl) rhs
      | RLia.Add ls, RLia.Add rs -> ofop (add (ls @ List.map negate rs)) (constz Z.zero)
      | RLia.Add (Const c :: tl), Const n -> ofop (add tl) (constz Z.(n - c))
      | Const c, Add (Const n :: tl) -> ofop (add (List.map negate tl)) (constz Z.(n - c))
      | Const c, Add xs -> ofop (add (List.map negate xs)) (constz Z.(-c))
      | _ -> ofop l r
    ;;

    let cancel_left op lhs rhs =
      let open Ast.RLia in
      let simplify divisor =
        let divide_by d = function
          | Mul (Const lc :: ltl) -> Mul (Const Z.(lc / d) :: ltl)
          | Const lc -> Const Z.(lc / d)
          | lt when Z.(d = one) -> lt
          | other -> failwith "Unexpected divison in linear term"
        in
        function
        | [] -> constz Z.zero
        | [ atom ] -> divide_by divisor atom
        | atoms -> Add (List.map (divide_by divisor) atoms)
      in
      let gcd atoms =
        let rec gcd acc = function
          | Mul (Const lc :: ltl) :: other -> Z.gcd lc (gcd acc other)
          | Const lc :: other -> Z.gcd lc (gcd acc other)
          | _ :: other -> Z.one
          | [] -> acc
        in
        max Z.one (gcd Z.zero atoms)
      in
      let lhs' = List.filter (fun x -> Bool.not (List.mem x rhs)) lhs in
      let rhs' = List.filter (fun x -> Bool.not (List.mem x lhs)) rhs in
      let d = Z.gcd (gcd lhs') (gcd rhs') in
      op (simplify d lhs') (simplify d rhs')
    ;;

    let eqz l r =
      let open Ast.RLia in
      match l, r with
      | l, r when eq_term l r -> true_
      | Add lhs, Add rhs -> cancel_left (relop Eq) lhs rhs
      | lhs, Add rhs -> cancel_left (relop Eq) [ lhs ] rhs
      | Add lhs, rhs -> cancel_left (relop Eq) lhs [ rhs ]
      | Mul (Const lc :: ltl), Mul (Const rc :: rtl) ->
        let gcd1 = Z.gcd lc rc in
        if Z.(equal gcd1 one)
        then relop Eq l r
        else
          relop Eq (mul (constz Z.(lc / gcd1) :: ltl)) (mul (constz Z.(rc / gcd1) :: rtl))
      | _ -> relop Eq l r
    ;;

    let leq l r =
      let open Ast.RLia in
      match l, r with
      | Add lhs, Add rhs -> cancel_left (relop Leq) lhs rhs
      | lhs, Add rhs -> cancel_left (relop Leq) [ lhs ] rhs
      | Add lhs, rhs -> cancel_left (relop Leq) lhs [ rhs ]
      | _ -> relop Leq l r
    ;;

    let lt l r = leq (add [ const 1; l ]) r

    let neqz l r =
      match l, r with
      | Ast.RLia.Const l, Ast.RLia.Const r -> if l <> r then Ast.true_ else Ast.false_
      | eiat1, eiat2 when Ast.RLia.eq_term eiat1 eiat2 -> Ast.false_
      | Add lhs, Add rhs -> cancel_left Id_symantics.neqz lhs rhs
      | lhs, Add rhs -> cancel_left Id_symantics.neqz [ lhs ] rhs
      | Add lhs, rhs -> cancel_left Id_symantics.neqz lhs [ rhs ]
      | _ -> Id_symantics.neqz l r
    ;;

    let from_rlia_nfa c =
      let module NfaStr = Nfa.Lsb (Nfa.Str) in
      let re =
        List.fold_left
          Regex.concat
          Regex.epsilon
          (Z.to_string c
           |> String.to_seq
           |> Seq.map (fun c -> [ c ])
           |> Seq.map Regex.symbol
           |> List.of_seq
           |> List.rev)
      in
      let re = Regex.concat re (Regex.kleene (Regex.Symbol [ Nfa.Str.u_zero ])) in
      NfaStr.of_regex re
    ;;

    let in_re s re =
      let module NfaStr = Nfa.Lsb (Nfa.Str) in
      match s with
      | Ast.RLia.Atom (Ast.Var (s, S)) ->
        begin match Env.lookup_string s env with
        | Some (Ast.RLia.Str_const _ as c) -> Ast.rlia (RLia.inre c Ast.S re)
        | Some (Ast.RLia.Const c) ->
          begin match
            NfaStr.of_regex re
            |> NfaStr.intersect (from_rlia_nfa c)
            |> NfaStr.run (*(String.to_seq str |> List.of_seq |> List.rev)*)
          with
          | true -> Ast.true_
          | false -> Ast.false_
          end
        | None | _ -> Ast.rlia (RLia.inre (RLia.Atom (Ast.Var (s, S))) Ast.S re)
        end
      | Ast.RLia.(Str_const str) ->
        begin match
          NfaStr.of_regex re
          |> NfaStr.re_accepts (String.to_seq str |> List.of_seq |> List.rev)
        with
        | true -> Ast.true_
        | false -> Ast.false_
        end
      | _ -> Id_symantics.in_re s re
    ;;

    let in_rei s re =
      let module NfaStr = Nfa.Lsb (Nfa.Str) in
      match s with
      | Ast.RLia.(Const c) ->
        begin match
          NfaStr.of_regex re |> NfaStr.intersect (from_rlia_nfa c) |> NfaStr.run
        with
        | true -> Ast.true_
        | false -> Ast.false_
        end
      | _ -> Id_symantics.in_rei s re
    ;;

    let in_re_raw s re =
      let module NfaStr = Nfa.Lsb (Nfa.Str) in
      match s with
      | Ast.RLia.(Str_const str) ->
        begin match
          Regex.str_to_re str |> NfaStr.of_regex |> NfaStr.intersect re |> NfaStr.run
        with
        | true -> Ast.true_
        | false -> Ast.false_
        end
      | _ -> Id_symantics.in_re_raw s re
    ;;

    let in_re_rawi s re =
      let module NfaStr = Nfa.Lsb (Nfa.Str) in
      match s with
      | Ast.RLia.(Const c) ->
        begin match re |> NfaStr.intersect (from_rlia_nfa c) |> NfaStr.run with
        | true -> Ast.true_
        | false -> Ast.false_
        end
      | _ -> Id_symantics.in_re_rawi s re
    ;;

    let prj : ph -> repr = Fun.id
  end
  in
  let module Main_symantics = struct
    include Main_symantics_
    include FT_SIG.Sugar (Main_symantics_)
  end
  in
  (module Main_symantics : SYM_SUGAR
    with type ph = Ast.t
     and type repr = Ast.t
     and type str = string Ast.RLia.term
     and type term = Z.t Ast.RLia.term)
;;

let subst_term (type a) env (term : a Ast.RLia.term) =
  let (module S : SYM_SUGAR_AST) = make_main_symantics ~agressive:true env in
  let on_z, on_s = apply_term_symantics (module S) in
  match Ast.RLia.cast_to_sterm term with
  | Some proof ->
    let p2 = Ast.RLia.proof_for_eq proof in
    Ast.Eq.cast (Ast.Eq.sym p2) (on_s (Ast.Eq.cast p2 term))
  | None ->
    (match Ast.RLia.cast_to_zterm term with
     | Some proof ->
       let p2 = Ast.RLia.proof_for_eq proof in
       Ast.Eq.cast (Ast.Eq.sym p2) (on_z (Ast.Eq.cast p2 term))
     | None -> assert false)
;;

exception Unsat
exception Sat of string * Env.t

module ZTM = Map.Make (struct
    type t = Z.t Ast.RLia.term

    let compare = Stdlib.compare
  end)

let gensym =
  let n = ref 0 in
  fun ?(prefix = "eee") () ->
    incr n;
    Printf.sprintf "%s%d" prefix !n
;;

let eq_propagation : ?multiple:bool -> Env.t -> Ast.t -> Env.t * Ast.t =
  let open Ast in
  let (module S : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  let trivial_simplify eta = subst_term Env.empty eta in
  let extend_exn env v rhs =
    let rhs = trivial_simplify rhs in
    Env.extend_exn env v rhs
  in
  let safe_extend_exn env v rhs =
    try Some (extend_exn env v rhs) with
    | Env.Occurs -> None
  in
  let fold_and_filter multiple f acc xs =
    let acc = ref acc in
    let changed = ref false in
    let xs =
      List.filter_map
        (fun h ->
           if multiple || !changed |> not
           then (
             match f !acc h with
             | Some acc2 ->
               if acc2 <> !acc then changed := true;
               acc := acc2;
               None
             | None -> Some h)
           else Some h)
        xs
    in
    !acc, xs
  in
  let helper orig_ast env ast =
    let module Set = Base.Set.Poly in
    let get_atoms =
      Ast.RLia.fold2
        (fun acc -> function
           | Ast.RLia.Atom (Ast.Var (s, _)) -> Set.add acc s
           | _ -> acc)
        (fun acc -> function
           | Ast.RLia.Atom (Ast.Var (s, _)) -> Set.add acc s
           | _ -> acc)
        Set.empty
    in
    let rec in_in_re_rawi v ast =
      match ast with
      | True | Pred _ -> false
      | RLia (InReRaw (Ast.RLia.Atom (Ast.Var (v, I)), I, _)) -> true
      | RLia _ -> false
      | Lnot ast' | Exists (_, ast') -> in_in_re_rawi v ast'
      | Land asts | Lor asts ->
        List.fold_left (fun acc ast -> acc || in_in_re_rawi v ast) false asts
      | Unsupp _ -> false
    in
    let var_can_subst v = Env.is_absent_key v env in
    let var_can_subst_complex v = var_can_subst v && not (in_in_re_rawi v orig_ast) in
    let single =
      fun env c1 (Var (vn1, _) as v1) c2 (Var (vn2, _) as v2) rhs ->
      let is_bad v = not (var_can_subst_complex v) in
      try
        match is_bad vn1, is_bad vn2 with
        | false, _
          when Env.is_absent_key vn1 env && Env.is_absent_key vn2 env && Z.(equal c1 one)
          ->
          Option.some
            (extend_exn
               env
               v1
               S.(add [ mul [ constz Z.minus_one; constz c2; Atom v2 ]; rhs ]))
        | _, false
          when Env.is_absent_key vn2 env && Env.is_absent_key vn2 env && Z.(equal c2 one)
          ->
          Option.some
            (extend_exn
               env
               v2
               S.(add [ mul [ constz Z.minus_one; constz c1; Atom v1 ]; rhs ]))
        | _ -> None
        (* TODO(Kakadu): Support proper occurs check to workaround recursive substitutions *)
        (* MS: I am going to add try / catch for the Occurs exceeption *)
        (* Note: presence of key means we already simplified this variable in another equality *)
      with
      | Env.Occurs -> None
    in
    match ast with
    (* **************************** String stuff *********************************** *)
    | RLia (RLia.Eq (Atom (Var (vn, _) as v), (Str_const str as rhs), S))
      when var_can_subst vn ->
      (* (= v 'str') *)
      Some (extend_exn env v rhs)
    | RLia (RLia.Eq ((Str_const str as rhs), Atom (Var (vn, S) as v), S))
      when var_can_subst vn ->
      (* (= 'str' v) *)
      Some (extend_exn env v rhs)
    | RLia (RLia.Eq (Atom (Var (vn, _) as v), rhs, S)) when var_can_subst vn ->
      safe_extend_exn env v rhs
    | RLia (RLia.Eq (lhs, Atom (Var (vn, _) as v), S)) when var_can_subst vn ->
      safe_extend_exn env v lhs
    | RLia (RLia.Eq (Atom (Var (vn, _) as v), (RLia.Iofs (Atom (Var _)) as rhs), _))
      when var_can_subst vn -> safe_extend_exn env v rhs
    (* **************************** integer stuff *********************************** *)
    | RLia
        (RLia.Eq
           ((Atom (Var (vn1, _) as v1) as lhs), (Atom (Var (vn2, _) as v2) as rhs), _)) ->
      (match var_can_subst_complex vn1, var_can_subst_complex vn2 with
       | true, other ->
         if Env.occurs_var env vn1 rhs then None else Some (extend_exn env v1 rhs)
       | false, true ->
         if Env.occurs_var env vn2 lhs then None else Some (extend_exn env v2 lhs)
       | false, false -> None)
    | RLia (RLia.Eq (Atom (Var (vn, I) as v1), (Const c as rhs), I))
    | RLia (RLia.Eq ((Const c as rhs), Atom (Var (vn, I) as v1), I))
      when var_can_subst vn ->
      (* (= v c) *)
      Some (extend_exn env v1 rhs)
    | RLia (RLia.Eq (Mul [ Const _; Atom (Var (vn, _) as v) ], (Const z as rhs), _))
    | RLia (RLia.Eq ((Const z as rhs), Mul [ Const _; Atom (Var (vn, _) as v) ], _))
      when Z.(equal z zero) && var_can_subst vn ->
      (* (= ( * c v) 0) *)
      Some (extend_exn env v rhs)
    | RLia (RLia.Eq (Mul [ Const cl; Atom (Var (vn, _) as v) ], Const cr, _))
    | RLia (RLia.Eq (Const cr, Mul [ Const cl; Atom (Var (vn, _) as v) ], _))
      when Z.(cr mod cl = zero) && var_can_subst_complex vn ->
      let rhs = RLia.(Const Z.(cr / cl)) in
      Some (extend_exn env v rhs)
    | RLia (RLia.Eq (Atom (Var (vn, I) as vr), Mul [ Const cl; Atom (Var (vn2, I)) ], I))
    | RLia (RLia.Eq (Mul [ Const cl; Atom (Var (vn, I)) ], Atom (Var (vn2, I) as vr), I))
      when vn == vn2 && var_can_subst vn ->
      (* (= ( * c v) vr) *)
      Some (extend_exn env vr (Const Z.zero))
    | RLia
        (RLia.Eq
           ( Mul [ Const cl; Atom (Var (vn, I) as vr) ]
           , Mul [ Const cl2; Atom (Var (vn2, I)) ]
           , I ))
      when vn == vn2 && cl <> cl2 && var_can_subst vn ->
      Some (extend_exn env vr (Const Z.zero))
    | RLia
        (RLia.Eq
           ( Add
               [ Atom (Var (v1n, _) as v1); Mul [ Const c; (Atom (Var (v2n, _)) as v2) ] ]
           , Const z0
           , I ))
    | RLia
        (RLia.Eq
           ( Const z0
           , Add
               [ Atom (Var (v1n, _) as v1); Mul [ Const c; (Atom (Var (v2n, _)) as v2) ] ]
           , I ))
      when Z.(equal z0 zero) && var_can_subst_complex v1n ->
      (* (= (+ v1 c*v2)) 0) *)
      if Env.occurs_var env v1n v2
      then None
      else (
        let new_rhs =
          if Z.(equal c minus_one) then v2 else RLia.Mul [ Const Z.(-c); v2 ]
        in
        Some (extend_exn env v1 new_rhs))
    | RLia (RLia.Eq (Add [ Atom (Var (_, I) as v1); Atom (Var (_, I) as v2) ], rhs, I))
      when v1 <> v2 ->
      (* (= (+ v1 v2) rhs) *)
      (* log "%s %d. ast = %a" __FILE__ __LINE__ Ast.pp_smtlib2 ast; *)
      single env Z.one v1 Z.one v2 rhs
    | RLia
        (RLia.Eq
           ( Add [ Atom (Var (vn1, _) as v1); Mul [ Const c2; Atom (Var (vn2, _) as v2) ] ]
           , rhs
           , I ))
      when vn1 <> vn2 ->
      (* (= (+ v1 ( * c v2)) rhs) *)
      single env Z.one v1 c2 v2 rhs
    | RLia
        (RLia.Eq
           ( Add [ Mul [ Const c1; Atom (Var (vn1, _) as v1) ]; Atom (Var (vn2, _) as v2) ]
           , rhs
           , I ))
      when vn1 <> vn2 ->
      (* (= (+ ( * c v1) v2) rhs) *)
      single env c1 v1 Z.one v2 rhs
    | RLia
        (RLia.Eq
           ( Add
               [ Mul [ Const c1; Atom (Var (vn1, _) as v1) ]
               ; Mul [ Const c2; Atom (Var (vn2, _) as v2) ]
               ]
           , rhs
           , I ))
      when vn1 <> vn2 -> single env c1 v1 c2 v2 rhs
    | RLia (RLia.Eq (Add sums, Const rhs, I)) when Z.(zero = rhs) ->
      (* (= (+ ...) 0) *)
      let not_touched_by_env env term =
        try
          let f env = function
            | RLia.Atom (Var (v, _)) when not (Env.is_absent_key v env) -> raise Exit
            | _ -> env
          in
          let _ : Env.t = RLia.fold_term f (fun acc _ -> acc) env term in
          true
        with
        | Exit -> false
      in
      let maybe_extend env vn v data ~fk =
        if not (Env.occurs_var env vn data) then extend_exn env v data else fk ()
      in
      let rec loop acc = function
        | RLia.Atom (Var (v, _)) :: _ when not (Env.is_absent_key v env) -> raise Exit
        | RLia.Atom (Var (vn, _) as v) :: xs when var_can_subst_complex vn ->
          let data = S.(mul [ constz Z.minus_one; add (acc @ xs) ]) in
          maybe_extend env vn v data ~fk:(fun () -> loop (RLia.Atom v :: acc) xs)
        | (Mul [ Const c; RLia.Atom (Var (vn, _) as v) ] as leftmost) :: xs
          when var_can_subst_complex vn
               && Z.(equal (of_int (-1)) c)
               && not_touched_by_env env (RLia.Add acc)
               && not_touched_by_env env (RLia.Add xs) ->
          let data = S.(mul [ add (acc @ xs) ]) in
          maybe_extend env vn v data ~fk:(fun () -> loop (leftmost :: acc) xs)
        | h :: tl -> loop (h :: acc) tl
        | [] -> raise Exit
      in
      (try Some (loop [] sums) with
       | Exit -> None)
    | RLia (RLia.Eq (Atom (Var (vn, _)), rhs, _))
      when match rhs with
           | Bwand _ | Bwor _ | Bwxor _ -> true
           | _ -> false -> None
    | RLia (RLia.Eq (Atom (Var (vn, _) as v), rhs, _) as rlia')
      when (not (Env.occurs_var env vn rhs))
           && var_can_subst_complex vn
           && Ast.forsome
                (function
                  | RLia rlia'' when rlia' <> rlia'' && Set.mem (get_atoms rlia'') vn ->
                    true
                  | _ -> false)
                orig_ast -> Some (extend_exn env v rhs)
    | RLia (RLia.Eq (lhs, Atom (Var (vn, _)), _))
      when match lhs with
           | Bwand _ | Bwor _ | Bwxor _ -> true
           | _ -> false -> None
    | RLia (RLia.Eq (lhs, Atom (Var (vn, _) as v), _) as rlia')
      when var_can_subst_complex vn
           && (function
                | RLia rlia'' when rlia' <> rlia'' && Set.mem (get_atoms rlia'') vn ->
                  true
                | _ -> false)
                orig_ast -> Some (extend_exn env v lhs)
    | eq -> None
    (* None means left as it is *)
  in
  fun ?multiple env ast ->
    let multiple = Option.value ~default:false multiple in
    match ast with
    | Land xs ->
      let env', ys = fold_and_filter multiple (helper ast) env xs in
      let ans_ph = if ys = [] && xs <> [] then True else Ast.land_ ys in
      env', ans_ph
    | RLia _ ->
      (match helper ast env ast with
       | Some e -> e, Ast.True
       | None -> env, ast)
    | ph -> env, ph
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ?(env = [ "x"; "y"; "z" ]) ?(exp = []) ph =
    let env2, _ = eq_propagation Env.empty ph in
    Format.printf "@[%a@]\n%!" (Env.pp ~title:"") env2
  in
  test TS.(add [ mul [ const 1; var "x" ]; mul [ const 2; var "y" ] ] = var "z");
  [%expect "x -> (+ z (* (- 2) y));"];
  test TS.(add [ var "x"; mul [ const 2; var "y" ] ] = mul [ var "z"; var "z" ]);
  [%expect "x -> (+ (* (- 2) y) (* z z));"];
  test ~exp:[ "x" ] TS.(add [ var "x"; var "y" ] = mul [ var "z"; var "z" ]);
  [%expect "y -> (+ (- x) (* z z));"];
  ()
;;

(* type step = int list *)
let next = function
  | [] -> failwith "Bad argument: next_step"
  | h :: tl -> (1 + h) :: tl
;;

let pp_step fmt step =
  Format.pp_print_list
    ~pp_sep:(fun ppf () -> Format.fprintf ppf ".")
    Format.pp_print_int
    fmt
    (List.rev step)
;;

let lower_mod ast =
  let acc = ref [] in
  let extend ph = acc := ph :: !acc in
  let module M = struct
    include Id_symantics

    let mod_ t z =
      let r = var (gensym ~prefix:"%r" ()) in
      let q = var (gensym ~prefix:"%q" ()) in
      let zz = Ast.RLia.(Const z) in
      extend (leq (constz Z.zero) r);
      extend (lt r zz);
      extend (eqz t (add [ mul [ zz; q ]; r ]));
      r
    ;;
  end
  in
  let ph = apply_symantics_unsugared (module M) ast in
  match !acc with
  | [] -> ph
  | acc -> Ast.land_ (ph :: acc)
;;

module
  Collect_alpha_
  (*: SYM_SUGAR with type repr = char Base.Set.Poly.t and type ph = char Base.Set.Poly.t*) =
struct
  module S = Base.Set.Poly

  type term = char S.t

  let ( ++ ) = S.union
  let empty = S.empty

  type ph = term
  type str = term
  type repr = ph

  let in_re lhs re =
    lhs ++ (Regex.symbols re |> List.map (fun a -> List.nth a 0) |> S.of_list)
  ;;

  let in_rei lhs re = lhs ++ empty
  let in_re_raw lhs re = lhs ++ NfaS.alpha re
  let in_re_rawi lhs re = lhs ++ NfaS.alpha re
  let iofs s = s
  let str_const s = String.to_seq s |> List.of_seq |> S.of_list

  let str_var v =
    (* Format.printf "%s %d: %s\n%!" __FUNCTION__ __LINE__ v; *)
    empty
  ;;

  let const _ = empty
  let constz _ = empty
  let var s = empty
  let pp_str fmt ph = Format.fprintf fmt "todo"

  let mul xs =
    let aaa = List.fold_left ( ++ ) empty xs in
    (* let u2 =
      match xs with
      | [ RLia.Atom (Var (v,_)); RLia.Pow (RLia.  (Const 2), RLia.Atom (Var _)) ] ->
        S.singleton v
      | _ -> S.empty
    in
    { aaa with under2 = S.union aaa.under2 u2 } *)
    aaa
  ;;

  let add = List.fold_left ( ++ ) empty
  let mod_ x _ = x
  let bw _ = ( ++ )
  let true_ = empty
  let false_ = empty
  let land_ = List.fold_left ( ++ ) empty
  let lor_ = List.fold_left ( ++ ) empty
  let not = Fun.id
  let pred _ = empty
  let eqz = ( ++ )
  let neqz = ( ++ )
  let leq = ( ++ )
  let lt = ( ++ )

  let exists _ info =
    (* This place could be buggy when name clashes  *)
    info
  ;;

  let v = ( ++ )
  let prj = Fun.id
  let unsupp _ = empty
end

module Collect_alpha :
  SYM_SUGAR with type repr = Collect_alpha_.repr and type ph = Collect_alpha_.repr =
struct
  include Collect_alpha_
  include FT_SIG.Sugar (Collect_alpha_)
end

let collect_alpha ast = apply_symantics (module Collect_alpha) ast
let alpha_with_extra_char = fun x -> x |> collect_alpha |> Utils.with_extra_char

let subst env ast =
  let (module S : SYM_SUGAR_AST) = make_main_symantics ~agressive:true env in
  let rec loop ast =
    let ast2 = apply_symantics_unsugared (module S) ast in
    if Ast.equal ast ast2 then ast else loop ast2
  in
  loop ast
;;

let basic_simplify step ?multiple (env : Env.t) ast =
  (*AM: removed the following trace logger: let log =
    if step = [ 0 ] then fun ppf -> Format.ifprintf Format.std_formatter ppf else log
  in *)
  trace_log "iter(%a)= @[%a@]" pp_step step Ast.pp_smtlib2 ast;
  let alpha = alpha_with_extra_char ast in
  trace_log
    "Alphabet with extra char: %a%!"
    Format.(pp_print_list ~pp_sep:(fun ppf () -> fprintf ppf " ") pp_print_char)
    alpha;
  let rec loop step (env : Env.t) ast =
    let (module Symantics) = make_main_symantics ~alpha env in
    let rez = apply_symantics (module Symantics) ast in
    let ast2 = Symantics.prj rez in
    let env2, ast2 = eq_propagation ?multiple env ast2 in
    let __ _ = trace_log "env2 = %a" (Env.pp ~title:"") env2 in
    let __ () = trace_log "ast2 = @[%a@]" Ast.pp_smtlib2 ast2 in
    let next_step = next step in
    match Env.length env2 > Env.length env, Ast.safe_eq ast ast2 with
    | true, equal ->
      let () = trace_log "%a" (Env.pp ~title:"Something ready to substitute") env2 in
      let __ () = trace_log "ast2 = @[%a@]" Ast.pp_smtlib2 ast2 in
      if not equal then trace_log "iter(%a)= @[%a@]" pp_step next_step Ast.pp_smtlib2 ast2;
      loop next_step (Env.merge_exn env2 env) ast2
    | false, false ->
      trace_log "iter(%a)= @[%a@]" pp_step next_step Ast.pp_smtlib2 ast2;
      loop next_step env ast2
    | false, true ->
      trace_log "fixed-point";
      (match ast2 with
       | Ast.True -> raise (Sat ("presimpl", env))
       | Ast.Lnot Ast.True -> raise Unsat
       | _ -> ast2, env, step)
  in
  try `Unknown (loop step env ast) with
  | Unsat -> `Unsat
  | Sat (_, env) -> `Sat env
;;

let run_basic_simplify ?(env = Env.empty) ast =
  trace_log "Basic simplifications...";
  let ast = lower_mod ast in
  if Ast.is_conjunct ast
  then (
    match basic_simplify [ 1 ] env ast with
    | `Sat env -> `Sat ("presimpl int", env)
    | `Unsat -> `Unsat
    | `Unknown (ast, e, _) -> `Unknown (ast, e))
  else `Unknown (subst Env.empty ast, Env.empty)
;;
