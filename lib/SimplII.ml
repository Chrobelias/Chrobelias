(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)
[@@@warning "+unused-value-declaration"]

let trace_log fmt = Debug.trace "simpl" fmt

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

  val sofi : term -> str
  val iofs : str -> term
  val str_from_eia_const : Z.t -> str
  val str_len2 : str -> term
  val str_at : str -> string -> str
  val str_substr : str -> term -> term -> str
  val str_prefixof : str -> str -> ph
  val str_contains : str -> str -> ph
  val str_suffixof : str -> str -> ph

  (* String formulas *)
  val str_concat : str -> str -> str

  (* All formulas  *)
  val pow2var : string -> term
  val exists : Ast.any_atom list -> ph -> ph
  val unsupp : string -> ph
  val pow_minus_one : term -> term
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
  val rlen : term -> term -> ph
end

module type SYM_SUGAR = sig
  include SYM
  include FT_SIG.s_extra with type ph := ph and type term := term
end

module type SYM_SUGAR_AST =
  SYM_SUGAR
  with type ph = Ast.t
   and type repr = Ast.t
   and type str = string Ast.Eia.term
   and type term = Z.t Ast.Eia.term

module Id_symantics :
  SYM
  with type ph = Ast.t
   and type repr = Ast.t
   and type term = Z.t Ast.Eia.term
   and type str = string Ast.Eia.term = struct
  type term = Z.t Ast.Eia.term
  type str = string Ast.Eia.term

  let pp_str = Ast.Eia.pp_term

  type ph = Ast.t
  type repr = Ast.t

  (** Terms *)
  let bw k a b =
    match k with
    | FT_SIG.Bwand -> Ast.Eia.bwand a b
    | FT_SIG.Bwor -> Ast.Eia.bwor a b
    | FT_SIG.Bwxor -> Ast.Eia.bwxor a b
  ;;

  include struct
    open Ast.Eia

    let in_re l regex = Ast.Eia (Ast.Eia.InRe (l, Ast.S, regex))
    let in_rei l regex = Ast.Eia (Ast.Eia.InRe (l, Ast.I, regex))
    let in_re_raw l regex = Ast.Eia (Ast.Eia.InReRaw (l, Ast.S, regex))
    let in_re_rawi l regex = Ast.Eia (Ast.Eia.InReRaw (l, Ast.I, regex))
    let rlen term term' = Ast.Eia (Ast.Eia.RLen (term, term'))
    let str_len s = len s
    let str_len2 s1 = len2 s1
    let iofs x = Ast.Eia.Iofs x
    let sofi x = Ast.Eia.Sofi x
  end

  (* let str_from_eia s = Ast.Str.FromEia (Ast.var s) *)
  let str_prefixof s1 s2 = Ast.eia (Ast.Eia.prefixof s1 s2)
  let str_contains s1 s2 = Ast.eia (Ast.Eia.contains s1 s2)
  let str_suffixof s1 s2 = Ast.eia (Ast.Eia.suffixof s1 s2)

  (* let str_from_eia_const c = Ast.Eia.Atom (Str_const (Z.to_string c))
  let str_concat s1 s2 = Ast.Eia.concat s1 s2 *)
  let str_from_eia_const c = Ast.Eia.sofi (Const c)
  let str_concat s1 s2 = Ast.Eia.concat s1 s2
  let mod_ = Ast.Eia.mod_
  let pow = Ast.Eia.pow
  let mul = Ast.Eia.mul
  let add = Ast.Eia.add
  let land_ xs = Ast.land_ xs
  let lor_ xs = Ast.lor_ xs
  let not = Ast.lnot
  let pred s = Ast.pred s
  let str_var s : str = Atom (Ast.Var (s, S))
  let str_const s : str = Ast.Eia.Str_const s
  let constz s = Ast.Eia.Const s
  let const s : term = constz (Z.of_int s)
  let str_at s a = Ast.Eia.at s (Ast.Eia.Atom (Ast.Var (a, I)))
  let str_substr s a b = Ast.Eia.substr s a b

  (* Ast.Eia.substr s a b *)
  (* include Ast *)

  (* Formulas *)

  let var s = Ast.Eia.Atom (Ast.Var (s, I))
  let exists atoms ph = Ast.exists atoms ph
  let eqz l r = Ast.Eia (Ast.Eia.eq l r Ast.I)
  let neqz l r = Ast.Eia (Ast.Eia.neq l r Ast.I)
  let eq_str l r = Ast.Eia (Ast.Eia.eq l r Ast.S)
  let neq_str l r = Ast.Eia (Ast.Eia.neq l r Ast.S)
  let leq l r = Ast.Eia (Ast.Eia.leq l r)
  let lt l r = Ast.Eia (Ast.Eia.lt l r)
  let true_ = Ast.true_
  let false_ = Ast.false_
  let prj = Fun.id
  let pow_minus_one t = pow (const (-1)) t

  let pow2var c =
    Ast.Eia.pow (Ast.Eia.const Config.config.enc_base) (Ast.Eia.atom (Ast.var c I))
  ;;

  let unsupp s = Ast.Unsupp s
end

let apply_term_symantics
      (type a b)
      (module S : SYM_SUGAR with type term = a and type str = b)
  =
  (* let helperS = apply_str_symantics (module S) in *)
  let rec helperT : Z.t Ast.Eia.term -> a = function
    | Ast.Eia.Const n -> S.constz n
    | Atom (Ast.Var (s, I)) -> S.var s
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    | Pow (Const base, p) when base = Z.minus_one -> S.pow_minus_one (helperT p)
    | Pow (Const base, Atom (Ast.Var (x, I))) when base = Config.config.enc_base ->
      S.pow (S.constz base) (S.var x)
    | Pow (base, p) -> S.pow (helperT base) (helperT p)
    | Bwand (l, r) -> S.bw FT_SIG.Bwand (helperT l) (helperT r)
    | Bwor (l, r) -> S.bw FT_SIG.Bwor (helperT l) (helperT r)
    | Bwxor (l, r) -> S.bw FT_SIG.Bwxor (helperT l) (helperT r)
    | Mod (t, z) -> S.mod_ (helperT t) z
    (* | (Iofs (Ast.Eia.Str_const _) | Len (Ast.Eia.Const _)) as t ->
      Format.eprintf "%a\n%!" Ast.Eia.pp_term t;
      failwith "Strlen/Stoi should not be called from int constants. Types are bad" *)
    | Len Ast.Eia.(Str_const s) -> S.constz (Z.of_int (String.length s))
    | Len t -> S.str_len (helperS t)
    | Iofs Ast.Eia.(Str_const s) ->
      (match int_of_string_opt s with
       | Some n -> S.constz (Z.of_int n)
       | None -> S.iofs (S.str_const s))
    | Iofs t -> S.iofs (helperS t)
    | Len2 s -> S.str_len2 (helperS s)
    | At (s1, _) -> failwith "unimplemented"
    | eia -> failwith (Format.asprintf "Not yet implement: %a" Ast.pp_term_smtlib2 eia)
  and helperS : string Ast.Eia.term -> S.str = function
    | Str_const s -> S.str_const s
    | Atom (Ast.Var (s, _)) -> S.str_var s
    | Sofi eia -> S.sofi (helperT eia)
    | At (s1, Atom (Var (a, I))) -> S.str_at (helperS s1) a
    | Concat (s1, s2) -> S.str_concat (helperS s1) (helperS s2)
    | Substr (s1, (Atom (Var (a, I)) as l), (Atom (Var (b, I)) as r)) ->
      S.str_substr (helperS s1) (helperT l) (helperT r)
    | Substr (s1, a, b) -> S.str_substr (helperS s1) (helperT a) (helperT b)
    | eia -> failwith (Format.asprintf "Not yet implement: %a" Ast.pp_term_smtlib2 eia)
  in
  (fun x -> helperT x), fun y -> helperS y
;;

module Info = struct
  type names = string Base.Set.Poly.t

  type t =
    { exp : names
    ; all : names
    ; str : names
    }

  let is_in_expo name { exp; _ } = Base.Set.Poly.mem exp name
  let is_in_string name { str; _ } = Base.Set.Poly.mem str name

  let make ~exp ~all ~str =
    (* TODO: check subsumtion *)
    let of_list = Base.Set.Poly.of_list in
    { exp = of_list exp; all = of_list all; str = of_list str }
  ;;

  let empty = make ~exp:[] ~all:[] ~str:[]

  let pp_exp ppf { exp; _ } =
    Format.fprintf
      ppf
      "exp: @[%a@]"
      Format.(
        pp_print_list Format.pp_print_string ~pp_sep:(fun ppf () -> fprintf ppf "@ "))
      (Base.Set.Poly.to_list exp)
  [@@ocaml.warning "-unused-value-declaration"]
  ;;

  let pp_hum ppf { exp; all; str } =
    let open Format in
    let pp_list =
      pp_print_list Format.pp_print_string ~pp_sep:(fun ppf () -> fprintf ppf "@ ")
    in
    fprintf ppf "@[<v>";
    fprintf ppf "@[Exp: @[%a@]@]@," pp_list (Base.Set.Poly.to_list exp);
    fprintf ppf "@[Str: @[%a@]@]@," pp_list (Base.Set.Poly.to_list str);
    fprintf ppf "@[ALL: @[%a@]@]" pp_list (Base.Set.Poly.to_list all);
    fprintf ppf "@]"
  ;;

  let union e1 e2 =
    let ( ++ ) = Base.Set.Poly.union in
    { exp = e1.exp ++ e2.exp; all = e1.all ++ e2.all; str = e1.str ++ e2.str }
  ;;
end

module Who_in_exponents_ = struct
  module S = Base.Set.Poly

  type term = Info.t

  let pp_str = Info.pp_hum

  open Info

  let pp_set ppf xs =
    Format.(fprintf ppf "@[%a@]" (pp_print_list pp_print_string ~pp_sep:pp_print_space))
      xs
  ;;

  let pp_info ppf { Info.exp; all; _ } =
    Format.printf
      "@[{ all = @[%a@];@ exp  = @[%a@] }@]"
      pp_set
      (Base.Set.Poly.to_list all)
      pp_set
      (Base.Set.Poly.to_list exp)
  [@@warning "-32"]
  ;;

  let ( ++ ) = Info.union
  let empty = Info.empty

  type ph = term
  type str = term
  type repr = ph

  let in_re _ _ = empty
  let in_rei _ _ = empty
  let in_re_raw _ _ = empty
  let in_re_rawi _ _ = empty
  let rlen = ( ++ )
  let str_len s = s
  let sofi s = s
  let iofs s = s
  let str_const _ = empty

  let str_var v =
    (* Format.printf "%s %d: %s\n%!" __FUNCTION__ __LINE__ v; *)
    { empty with str = S.singleton v }
  ;;

  let str_from_eia_const s = empty
  let str_concat = ( ++ )
  let const _ = empty
  let constz _ = empty
  let var s = { empty with all = S.singleton s }

  let str_len2 v =
    (* Format.printf "%s %d: %s\n%!" __FUNCTION__ __LINE__ v; *)
    v
  ;;

  let str_at _ _ = empty
  let str_substr _ _ _ = empty
  let str_prefixof = ( ++ )
  let str_contains = ( ++ )
  let str_suffixof = ( ++ )

  let mul xs =
    let aaa = List.fold_left ( ++ ) empty xs in
    (* let u2 =
      match xs with
      | [ Eia.Atom (Var (v,_)); Eia.Pow (Eia.  (Const 2), Eia.Atom (Var _)) ] ->
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
  let eq_str = ( ++ )
  let neq_str = ( ++ )
  let leq = ( ++ )
  let lt = ( ++ )
  let exists _ info = (* This place could be buggy when name clashes  *) info

  let pow2var v =
    let all = [ v ] in
    Info.make ~all ~exp:all ~str:[]
  ;;

  let pow_minus_one e = { e with all = S.union S.empty e.all }
  let pow base e = { e with all = S.union base.all e.all; exp = S.union e.all base.exp }
  let prj = Fun.id
  let unsupp _ = empty
end

module _ : SYM = Who_in_exponents_

module Who_in_exponents :
  SYM_SUGAR with type repr = Who_in_exponents_.repr and type ph = Who_in_exponents_.repr =
struct
  include Who_in_exponents_
  include FT_SIG.Sugar (Who_in_exponents_)
end

let apply_symantics (type a) (module S : SYM_SUGAR with type ph = a) =
  let helperT, helperS = apply_term_symantics (module S) in
  let rec helper = function
    | Ast.Land xs -> S.land_ (List.map helper xs)
    | Lor xs -> S.lor_ (List.map helper xs)
    | Lnot x -> S.not (helper x)
    | True -> S.true_
    | Eia e -> helper_eia e
    | Pred s -> assert false
    | Exists (vs, ph) ->
      (*let vs =
        List.filter_map
          (function
            (* These repeats very often  *)
            | Ast.Any_atom (Var (_, _)) as s -> Some s)
          vs
      in*)
      S.exists vs (helper ph)
    (* | Str (Ast.Str.Eq (term, term')) ->
      let l = helperT term in
      let r = helperT term' in
      (* Format.printf "Apply Str.Eq: l = %a, r = %a\n%!" S.pp_str l S.pp_str r; *)
      S.str_equal l r *)
    | Unsupp s -> S.unsupp s
  and helper_eia eia =
    match eia with
    | Ast.Eia.Eq (l, r, I) -> S.(helperT l = helperT r)
    | Eq (l, r, S) -> S.eq_str (helperS l) (helperS r)
    | Neq (l, r, I) -> S.(helperT l <> helperT r)
    | Neq (l, r, S) -> S.neq_str (helperS l) (helperS r)
    | Leq (l, r) -> S.(helperT l <= helperT r)
    | PrefixOf (term, term') -> S.str_prefixof (helperS term) (helperS term')
    | Contains (term, term') -> S.str_contains (helperS term) (helperS term')
    | SuffixOf (term, term') -> S.str_suffixof (helperS term) (helperS term')
    | InRe (term, Ast.S, regex) -> S.in_re (helperS term) regex
    | InRe (term, Ast.I, regex) -> S.in_rei (helperT term) regex
    | InReRaw (term, Ast.S, regex) -> S.in_re_raw (helperS term) regex
    | InReRaw (term, Ast.I, regex) -> S.in_re_rawi (helperT term) regex
    | RLen (term, term') -> S.rlen (helperT term) (helperT term')
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

    let compare_term = Eia.compare_term
    let constz c = Ast.Eia.Const c
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
        | _ -> Eia.Atom (Ast.Var (s, I))
        end
      | Some c ->
        (* log "Substuting %s ~~> %a" s Ast.pp_term_smtlib2 c; *)
        c
    ;;

    let str_var s : str =
      match Env.lookup_string s env with
      | Some c -> c
      | None ->
        begin match Env.lookup_int s env with
        | Some c -> Ast.Eia.sofi c
        | None -> Eia.Atom (Ast.Var (s, S))
        end
    ;;

    let rec str_len = function
      | Ast.Eia.Str_const s -> Id_symantics.const (String.length s)
      | Ast.Eia.Concat (l, r) -> add [ str_len l; str_len r ]
      | s -> Id_symantics.str_len s
    ;;

    let str_concat lhs rhs =
      match lhs, rhs with
      | Ast.Eia.Str_const lhs, Ast.Eia.Str_const rhs ->
        Id_symantics.str_const (String.concat "" [ lhs; rhs ])
      | Ast.Eia.Str_const c, rhs when String.equal c "" -> rhs
      | lhs, Ast.Eia.Str_const c when String.equal c "" -> lhs
      | lhs, rhs -> Id_symantics.str_concat lhs rhs
    ;;

    let str_len2 = function
      | Ast.Eia.Str_const s ->
        Id_symantics.constz Z.(pow Config.config.enc_base (String.length s) - one)
      | s -> Id_symantics.str_len2 s
    ;;

    let iofs = function
      | Ast.Eia.Concat (lhs, Ast.Eia.Str_const s) when String.for_all Base.Char.is_digit s
        ->
        Id_symantics.add
          [ Ast.Eia.mul
              [ Id_symantics.iofs lhs
              ; Ast.Eia.pow
                  (Id_symantics.constz Config.config.enc_base)
                  (Id_symantics.constz (Z.of_int (String.length s)))
              ]
          ; Id_symantics.constz (Z.of_string s)
          ]
      | Ast.Eia.Concat (lhs, Ast.Eia.Str_const s) -> Id_symantics.constz Z.minus_one
      | Ast.Eia.Concat (Ast.Eia.Str_const s, rhs) as term
        when String.for_all Base.Char.is_digit s -> Id_symantics.iofs term
      | Ast.Eia.Concat (Ast.Eia.Str_const s, rhs) -> Id_symantics.constz Z.minus_one
      | Ast.Eia.Str_const s ->
        begin match s with
        | "" -> Id_symantics.constz Z.minus_one
        | s when String.for_all Base.Char.is_digit s ->
          Id_symantics.constz (Z.of_string s)
        | _ -> Id_symantics.constz Z.minus_one
        end
      | s -> Id_symantics.iofs s
    ;;

    let sofi = function
      | Ast.Eia.Const s -> Id_symantics.str_const (Z.to_string s)
      | s -> Id_symantics.sofi s
    ;;

    let rlen term term' =
      match term with
      | Ast.Eia.Const c when Z.(c = minus_one) -> true_
      | _ -> Ast.Eia (Ast.Eia.RLen (term, term'))
    ;;

    (* let str_from_eia s =
      match Env.lookup s env with
      | Some (Ast.Eia.Atom (Ast.Const c)) -> Ast.Str.fromeia (Ast.const c)
      | _ -> Ast.Eia.fromeia (Ast.var s)
    ;; *)

    (*let str_equal l r =
    if Eia.eq_term l r
      then true_
      else (
        (*match l, r with
        (*| Eia.Sofi (Var v1 as l), Str.FromEia (Var v2 as r) ->
          Str (Str.Eq (Str.Atom l, Str.Atom r))*)
        | Str.FromEia (Const v1), Str.Const r | Str.Const r, Str.FromEia (Const v1) ->
          let l = Z.to_string v1 in
          if
            String.length l <= String.length r
            && String.ends_with ~suffix:l r
            && String.for_all
                 (Char.equal '0')
                 (String.sub r (String.length l) (String.length r - String.length l))
          then Ast.true_
          else Ast.false_
        | _ -> *)Id_symantics.str_eq l r)*)

    let str_prefixof s1 s2 =
      match s1, s2 with
      | Ast.Eia.Str_const s1, Ast.Eia.Str_const s2 ->
        if String.starts_with ~prefix:s1 s2
        then Id_symantics.true_
        else Id_symantics.false_
      | Ast.Eia.Str_const s1, s2 -> Id_symantics.in_re s2 (Regex.prefix s1)
      | s1, s2 -> Ast.eia (Ast.Eia.prefixof s1 s2)
    ;;

    let str_contains s1 s2 =
      match s1, s2 with
      | Ast.Eia.Str_const s1, Ast.Eia.Str_const s2 ->
        if Base.String.is_substring ~substring:s1 s2
        then Id_symantics.true_
        else Id_symantics.false_
      | Ast.Eia.Str_const s1, s2 -> Id_symantics.in_re s2 (Regex.contains s1)
      | s1, s2 -> Ast.eia (Ast.Eia.contains s1 s2)
    ;;

    let str_suffixof s1 s2 =
      match s1, s2 with
      | Ast.Eia.Str_const s1, Ast.Eia.Str_const s2 ->
        if String.ends_with ~suffix:s1 s2 then Id_symantics.true_ else Id_symantics.false_
      | Ast.Eia.Str_const s1, s2 -> Id_symantics.in_re s2 (Regex.suffix s1)
      | s1, s2 -> Ast.eia (Ast.Eia.suffixof s1 s2)
    ;;

    let collect_inside_mul xs =
      List.fold_right
        (fun x acc : term list ->
           match x, acc with
           | Eia.Mul ys, _ -> ys @ acc
           | e, Eia.Add ss :: tl | Add ss, e :: tl ->
             Add (List.map (fun x -> Eia.Mul [ x; e ]) ss) :: tl
           | Pow (base1, e1), Eia.Pow (base2, e2) :: tl when Stdlib.(base1 = base2) ->
             Eia.Pow (base1, Eia.Add [ e1; e2 ]) :: tl
           | Const c, Eia.Pow ((Const basec as base), Add (Const d :: ss)) :: tl
             when Z.(equal (abs c) basec) && d = Z.minus_one ->
             Eia.(Const Z.(c / basec)) :: Eia.Pow (base, Add ss) :: tl
           | x, _ -> x :: acc)
        xs
        []
    ;;

    let rec mul xs =
      let fold_and_sort init op xs =
        let c, xs =
          List.fold_left
            (fun (cacc, phacc) -> function
               | Eia.(Const c) -> op c cacc, phacc
               | Eia.Pow ((Const base as b), Eia.Add (Const minus1 :: sums))
                 when Z.(cacc mod base = Z.zero) && Z.equal Z.minus_one minus1 ->
                 Z.(cacc / base), Eia.Pow (b, Eia.Add sums) :: phacc
               | ph -> cacc, ph :: phacc)
            (init, [])
            xs
        in
        c, List.sort compare_term xs
      in
      match fold_and_sort Z.one Z.( * ) (collect_inside_mul xs) with
      | c, _ when Z.(equal c zero) -> Eia.Const Z.zero
      | c, [] -> Eia.Const c
      | c, [ h ] when Z.equal c Z.one -> h
      | c, xs when Z.equal c Z.one -> Ast.Eia.mul (List.sort compare_term xs)
      | c, [ Pow ((Const base_ as base), Add [ Const v1; v ]) ]
        when Z.(equal c Config.config.enc_base)
             && base_ = Config.config.enc_base
             && v1 = Z.minus_one -> pow base v
      | c, [ Add ss ] -> Eia.Add (List.map (fun x -> Eia.Mul [ constz c; x ]) ss)
      | c, xs -> Ast.Eia.mul (constz c :: List.sort compare_term xs)

    and pow base xs =
      match base, xs with
      | _, Eia.Const c when c = Z.zero -> const 1
      | Eia.Pow (base, e1), e2 -> Eia.Pow (base, Eia.Mul [ e1; e2 ])
      | Mul ((Const c as base0) :: tl), Eia.Const e ->
        mul [ pow base0 xs; pow (Mul tl) xs ]
      | Eia.Const b, Eia.Const exp when Z.(exp > zero) && agressive |> Option.is_none ->
        (try const (Z.to_int (Utils.powz ~base:b exp)) with
         | Z.Overflow -> Ast.Eia.Pow (base, xs))
      | Eia.Const b, Eia.Const exp
        when Z.(exp > zero) && agressive |> Option.value ~default:false ->
        constz (Utils.powz ~base:b exp)
      | _ -> Ast.Eia.Pow (base, xs)
    ;;

    let rec add xs =
      let collect_inside_add xs =
        let extend h tl =
          let rec loop c1 tl1 = function
            | ph :: ptl when ph = Eia.Mul tl1 ->
              if Z.(equal c1 minus_one)
              then ptl
              else Eia.Mul (Eia.Const Z.(one + c1) :: tl1) :: ptl
            | Eia.Mul (Eia.Const c2 :: tl2) :: ptl when Stdlib.(tl1 = tl2) ->
              if Z.(c1 + c2 = zero)
              then ptl
              else Eia.Mul (Eia.Const Z.(c1 + c2) :: tl1) :: ptl
            | ph :: ptl -> ph :: loop c1 tl1 ptl
            | [] -> [ h ]
          in
          match h with
          | Eia.Mul (Eia.Const c1 :: tl1) -> loop c1 tl1 tl
          | Eia.Mul tl1 -> loop Z.one tl1 tl
          | _ -> h :: tl
        in
        List.fold_right
          (fun x acc ->
             match x, acc with
             | Eia.Add ts, _ -> ts @ acc
             | Mul (Const c1 :: ph1), Eia.Mul (Const c2 :: ph2) :: tl
               when List.equal Ast.Eia.eq_term ph1 ph2 ->
               if Z.(c1 + c2 = zero) then tl else mul (Const Z.(c1 + c2) :: ph1) :: tl
             | Mul [ Const c1; ph1 ], ph2 :: tl when Ast.Eia.eq_term ph1 ph2 ->
               extend (mul [ Const Z.(of_int 1 + c1); ph1 ]) tl
             | a, _ -> extend a acc)
          xs
          []
      in
      let fold_and_sort init op xs =
        (* TODO(Kakadu): Maybe this presorting is not really needed... *)
        let c, xs =
          List.fold_left
            (fun (cacc, phacc) -> function
               | Eia.Const c -> op c cacc, phacc
               | ph -> cacc, ph :: phacc)
            (init, [])
            xs
        in
        c, List.sort compare_term xs
      in
      match fold_and_sort Z.zero Z.( + ) (collect_inside_add xs) with
      | c, [ Eia.Atom (Var (x, I)); Mul [ Eia.(Const x1); Eia.Atom (Var (x2, _)) ] ]
        when Z.(c = zero) && x = x2 && x1 = Z.minus_one -> const 0
      | c, Mul [ Eia.(Const c1); t1 ] :: Mul [ Eia.(Const c2); t2 ] :: tl
        when Stdlib.(t1 = t2) ->
        if c1 = Z.(minus_one * c2)
        then add (constz c :: tl)
        else add (constz c :: Mul [ Eia.Const Z.(c1 + c2); t1 ] :: tl)
      | c, [ h ] when Z.(equal c zero) -> h
      | c, [] when Z.(equal c zero) -> const 0
      | c, xs when Z.(equal c zero) ->
        let ans = Ast.Eia.add (List.sort compare_term xs) in
        ans
      | c, [] -> constz c
      | c, xs -> Ast.Eia.add (constz c :: List.sort compare_term xs)
    ;;

    let rec negate = function
      | Eia.Add xs -> add (List.map negate xs)
      | x -> mul [ const (-1); x ]
    ;;

    (** Formulas *)
    let exists var ph = Ast.exists var ph

    let true_ = Ast.true_
    let false_ = Ast.false_

    let rec not = function
      | Ast.Eia (Ast.Eia.Leq (lhs, rhs)) -> Ast.eia (Ast.Eia.gt lhs rhs)
      (* TODO: this is a dishonest invert here. It actually uses 0-9$ as an alphabet. *)
      | Ast.Eia (Ast.Eia.InReRaw (v, S, re)) when Option.is_some alpha ->
        Id_symantics.in_re_raw v (re |> NfaS.invert ?alpha)
      | Ast.Eia (Ast.Eia.InReRaw (v, I, re)) when Option.is_some alpha ->
        Id_symantics.in_re_rawi v (re |> NfaS.invert ?alpha)
      (* TODO: this is a dishonest invert here. It actually uses 0-9$ as an alphabet. *)
      | Ast.Eia (Ast.Eia.InRe (v, kind, re)) when Option.is_some alpha ->
        Ast.eia (Ast.Eia.inreraw v kind (NfaS.invert ?alpha (NfaS.of_regex re)))
      | Ast.Eia (Ast.Eia.Eq (lhs, rhs, I)) -> Id_symantics.neqz lhs rhs
      | Ast.Eia (Ast.Eia.Eq (lhs, rhs, S)) -> Id_symantics.neq_str lhs rhs
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

    let lor_ x = Ast.Lor x

    let relop op l r =
      let ofop =
        match op with
        | Leq -> fun x y -> Eia (Eia.leq x y)
        | Eq -> fun x y -> Eia (Eia.eq x y I)
      in
      match l, r with
      | Eia.(Const l), Eia.(Const r) ->
        (match op with
         | Eq when Z.equal l r -> true_
         | Eq -> false_
         | Leq when l <= r -> true_
         | Leq -> false_)
      | Eia.(Add (Atom (Var (v1, _)) :: Mul [ Const c; Atom (Var (v2, _)) ] :: tl)), rhs
        when String.equal v1 v2 && c = Z.minus_one -> ofop (Eia.Add tl) rhs
      | Eia.Add ls, Eia.Add rs -> ofop (add (ls @ List.map negate rs)) (constz Z.zero)
      | Eia.Add (Const c :: tl), Const n -> ofop (add tl) (constz Z.(n - c))
      | Const c, Add (Const n :: tl) -> ofop (add (List.map negate tl)) (constz Z.(n - c))
      | Const c, Add xs -> ofop (add (List.map negate xs)) (constz Z.(-c))
      | Pow (basel, powl), Pow (baser, powr) when basel = baser -> ofop powl powr
      (*| Eia.Mul [ Const c; (Atom (Var (_, _)) as v) ], Eia.(Const rhs)
        when op = Leq && Z.(abs c <> one) ->
        (* optimizing single bounds *)
        if Z.(equal zero rhs)
        then ofop Eia.(Mul [ Const (Z.of_int (Z.sign c)); v ]) r
        else if Z.(c < zero) && Z.(rhs < zero)
        then
          ofop
            Eia.(Mul [ Const Z.minus_one; v ])
            (mul [ Const Z.minus_one; Const Z.((abs rhs + one) / abs c) ])
        else if Z.(c > zero) && Z.(rhs > zero)
        then ofop v (Const Z.(abs rhs / c))
        else
          (* TODO(Kakadu): Support other three cases *)
          ofop l r*)
      | Eia.Pow (Eia.(Const base), Eia.Add (Const n :: etail)), _
        when Z.(n < zero) && Z.fits_int n ->
        ofop
          (Eia.Pow (Eia.(Const base), Eia.Add etail))
          (mul [ pow (constz base) (constz (Z.abs n)); r ])
      | _ -> ofop l r
    ;;

    let lt l r = relop Leq (add [ const 1; l ]) r
    let leq = relop Leq

    let eq_str l r =
      match l, r with
      | Eia.Sofi (Atom (Var _) as l), Eia.Sofi (Atom (Var _) as r) ->
        Eia (Eia.Eq (l, r, I))
      | Str_const c1, Str_const c2 -> if String.equal c1 c2 then Ast.true_ else Ast.false_
      | lhs, rhs when Eia.eq_term lhs rhs -> Ast.true_
      | Eia.Concat (l, Str_const c1), Eia.Concat (r, Str_const c2) ->
        (match String.length c1 - String.length c2 with
         | 0 -> if String.equal c1 c2 then Id_symantics.eq_str l r else false_
         | d when d > 0 ->
           if Base.String.is_suffix c1 ~suffix:c2
           then (
             let c1' = Base.String.chop_suffix_if_exists c1 ~suffix:c2 in
             Id_symantics.eq_str (Eia.Concat (l, Id_symantics.str_const c1')) r)
           else false_
         | _ ->
           if Base.String.is_suffix c2 ~suffix:c1
           then (
             let c2' = Base.String.chop_suffix_if_exists c2 ~suffix:c1 in
             Id_symantics.eq_str l (Eia.Concat (r, Id_symantics.str_const c2')))
           else false_)
      | Eia.Concat (Str_const c1, l), Eia.Concat (Str_const c2, r) ->
        (match String.length c1 - String.length c2 with
         | 0 -> if String.equal c1 c2 then Id_symantics.eq_str l r else false_
         | d when d > 0 ->
           if Base.String.is_prefix c1 ~prefix:c2
           then (
             let c1' = Base.String.chop_prefix_if_exists c1 ~prefix:c2 in
             Id_symantics.eq_str (Eia.Concat (Id_symantics.str_const c1', l)) r)
           else false_
         | _ ->
           if Base.String.is_prefix c2 ~prefix:c1
           then (
             let c2' = Base.String.chop_prefix_if_exists c2 ~prefix:c1 in
             Id_symantics.eq_str l (Eia.Concat (Id_symantics.str_const c2', r)))
           else false_)
      | _ -> Id_symantics.eq_str l r
    ;;

    let neq_str l r =
      match l, r with
      | Ast.Eia.Str_const l, Ast.Eia.Str_const r ->
        if l <> r then Ast.true_ else Ast.false_
      | (v, Ast.Eia.Str_const c | Ast.Eia.Str_const c, v) when Option.is_some alpha ->
        Id_symantics.in_re_raw v (Regex.str_to_re c |> NfaS.of_regex |> NfaS.invert ?alpha)
      | v, Ast.Eia.Str_const c | Ast.Eia.Str_const c, v -> failwith "BABKI, BABKI!"
      | eiat1, eiat2 when Ast.Eia.eq_term eiat1 eiat2 -> Ast.false_
      | _ -> Id_symantics.neq_str l r
    ;;

    let eqz l r =
      let open Ast.Eia in
      match l, r with
      | Mul (Const lc :: ltl), Mul (Const rc :: rtl) ->
        let gcd1 = Z.gcd lc rc in
        if Z.(equal gcd1 one)
        then relop Eq l r
        else
          relop Eq (mul (constz Z.(lc / gcd1) :: ltl)) (mul (constz Z.(rc / gcd1) :: rtl))
      | l, r when eq_term l r -> true_
      | _ -> relop Eq l r
    ;;

    let neqz l r =
      match l, r with
      | Ast.Eia.Const l, Ast.Eia.Const r -> if l <> r then Ast.true_ else Ast.false_
      | eiat1, eiat2 when Ast.Eia.eq_term eiat1 eiat2 -> Ast.false_
      | _ -> Id_symantics.neqz l r
    ;;

    let from_eia_nfa c =
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
      | Ast.Eia.Atom (Ast.Var (s, S)) ->
        begin match Env.lookup_string s env with
        | Some (Ast.Eia.Str_const _ as c) -> Ast.eia (Eia.inre c Ast.S re)
        | Some (Ast.Eia.Const c) ->
          begin match
            NfaStr.of_regex re
            |> NfaStr.intersect (from_eia_nfa c)
            |> NfaStr.run (*(String.to_seq str |> List.of_seq |> List.rev)*)
          with
          | true -> Ast.true_
          | false -> Ast.false_
          end
        (* | Some (Ast.Eia.Atom c) -> Ast.str (Str.inre (Eia.Sofi (Atom c)) re) *)
        | None | _ -> Ast.eia (Eia.inre (Eia.Atom (Ast.Var (s, S))) Ast.S re)
        end
      | Ast.Eia.Sofi (Const c) ->
        (* v = sofi 4 <=> v="4" | v="04" | v="004" | ... *)
        begin match
          NfaStr.of_regex re
          |> NfaStr.intersect (from_eia_nfa c)
          |> NfaStr.run (*(String.to_seq str |> List.of_seq |> List.rev)*)
        with
        | true -> Ast.true_
        | false -> Ast.false_
        end
      | Ast.Eia.(Str_const str) ->
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
      | Ast.Eia.(Const c) ->
        begin match
          NfaStr.of_regex re |> NfaStr.intersect (from_eia_nfa c) |> NfaStr.run
        with
        | true -> Ast.true_
        | false -> Ast.false_
        end
      | _ -> Id_symantics.in_rei s re
    ;;

    let in_re_raw s re =
      let module NfaStr = Nfa.Lsb (Nfa.Str) in
      match s with
      | Ast.Eia.(Str_const str) ->
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
      | Ast.Eia.(Const c) ->
        begin match re |> NfaStr.intersect (from_eia_nfa c) |> NfaStr.run with
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
     and type str = string Ast.Eia.term
     and type term = Z.t Ast.Eia.term)
;;

let subst_term (type a) env (term : a Ast.Eia.term) =
  let (module S : SYM_SUGAR_AST) = make_main_symantics ~agressive:true env in
  let on_z, on_s = apply_term_symantics (module S) in
  match Ast.Eia.cast_to_sterm term with
  | Some proof ->
    let p2 = Ast.Eia.proof_for_eq proof in
    Ast.Eq.cast (Ast.Eq.sym p2) (on_s (Ast.Eq.cast p2 term))
  | None ->
    (match Ast.Eia.cast_to_zterm term with
     | Some proof ->
       let p2 = Ast.Eia.proof_for_eq proof in
       Ast.Eq.cast (Ast.Eq.sym p2) (on_z (Ast.Eq.cast p2 term))
     | None -> assert false)
;;

let%test_module _ =
  (module struct
    let wrap f =
      let ast = Ast.land_ (f (make_main_symantics Env.empty)) in
      Format.printf "%a\n%!" Ast.pp_smtlib2 ast;
      let info = apply_symantics (module Who_in_exponents) ast in
      Format.printf "           @ @[%a@]%!" Info.pp_hum info
    ;;

    let%expect_test _ =
      wrap (fun (module TS : SYM_SUGAR_AST) ->
        let open TS in
        [ add [ pow2var "x"; pow2var "y" ] <= const 52
        ; add [ var "x"; mul [ const (-3); var "y" ] ] <= const 0
        ]);
      [%expect
        {|
        (and
          (<= (+ (exp 2 x) (exp 2 y)) 52)
          (<= (+ x (* (- 3) y)) 0))

        Exp: x y
        Str:
        ALL: x y
        |}]
    ;;

    let%expect_test _ =
      wrap (fun (module TS : SYM_SUGAR_AST) ->
        let open TS in
        [ mul [ var "x"; const 5 ] <= const 13
        ; add [ var "z"; var "x" ] <= const 52
        ; const 13
          <= add
               [ mul [ const 5; var "x" ]
               ; mul [ const 8; pow (const 2) (var "y") ]
               ; mul [ var "z"; const 7 ]
               ]
        ]);
      [%expect
        {|
        (and
          (<= (* 5 x) 13)
          (<= (+ x z) 52)
          (<= (+ (* (- 8) (exp 2 y)) (* (- 7) z) (* (- 5) x)) (- 13)))

        Exp: y
        Str:
        ALL: x y z
        |}]
    ;;
  end)
;;

exception Unsat
exception Sat of string * Env.t

module ZTM = Map.Make (struct
    type t = Z.t Ast.Eia.term

    let compare = Stdlib.compare
  end)

let propagate_exponents ast =
  let open Ast in
  let rec collect : ZTM.key ZTM.t -> Ast.t -> _ =
    fun acc -> function
      | Ast.Eia (Eia.Leq _) | Eia (Eia.Eq (Eia.Pow _, Eia.Pow _, I)) -> acc
      | Eia (Eia.Eq ((Eia.Pow _ as l), r, I)) -> collect acc (Eia (Eia.Eq (r, l, I)))
      | Eia (Eia.Eq (l, (Eia.Pow _ as r), I)) -> ZTM.add r l acc
      | _ -> acc
  in
  let info : ZTM.key ZTM.t =
    match ast with
    | Ast.Land xs -> List.fold_left collect ZTM.empty xs
    | _ -> collect ZTM.empty ast
  in
  let check key ~rhs =
    match ZTM.find key info with
    | exception Not_found -> key
    | t when Eia.eq_term rhs t -> key
    | t ->
      trace_log "%s: %a -> %a" __FUNCTION__ Ast.pp_term_smtlib2 key Ast.pp_term_smtlib2 t;
      t
  in
  let on_eia = function
    | Eia (Eia.Eq (l, r, I)) -> Eia (Eia.Eq (check l ~rhs:r, check r ~rhs:l, I))
    | Eia (Eia.Leq (l, r)) -> Eia (Eia.leq (check l ~rhs:r) (check r ~rhs:l))
    | x -> x
  in
  match ast with
  | Ast.Land xs -> Ast.land_ (List.map on_eia xs)
  | _ -> ast
;;

let gensym =
  let n = ref 0 in
  fun ?(prefix = "eee") () ->
    incr n;
    Printf.sprintf "%s%d" prefix !n
;;

let eq_propagation : Info.t -> ?multiple:bool -> Env.t -> Ast.t -> Env.t * Ast.t =
  let open Ast in
  let (module S : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  let trivial_simplify eta = subst_term Env.empty eta in
  let extend_exn env v rhs =
    let rhs = trivial_simplify rhs in
    (* log "extend %a --> %a" Ast.pp_atom v Ast.pp_term_smtlib2 rhs; *)
    Env.extend_exn env v rhs
  in
  let safe_extend_exn env v rhs =
    try Some (extend_exn env v rhs) with
    | Env.Occurs -> None
  in
  (*let extend_str_exn env v rhs = Env.extend_string_exn env v (trivial_simplify rhs) in*)
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
  let helper info orig_ast env ast =
    let module Set = Base.Set.Poly in
    let get_atoms =
      Ast.Eia.fold2
        (fun acc -> function
           | Ast.Eia.Atom (Ast.Var (s, _)) -> Set.add acc s
           | _ -> acc)
        (fun acc -> function
           | Ast.Eia.Atom (Ast.Var (s, _)) -> Set.add acc s
           | _ -> acc)
        Set.empty
    in
    (*let is_simple_eia eia =
      let on_int_term acc = function
        | Ast.Eia.Atom (Ast.Var (s, I)) -> Set.add acc s
        | _ -> acc
      in
      let on_str_term acc = function
        | Ast.Eia.Atom (Ast.Var (s, S)) -> Set.add acc s
        | _ -> acc
      in
      Ast.Eia.fold_term on_int_term on_str_term Set.empty eia |> Set.length <= 1
    in*)
    let in_strlen_eia v eia =
      Eia.fold2
        (fun acc el ->
           match el with
           | Eia.Len (Eia.Atom (Var (s, S))) when s = v -> true
           (*| Eia.Atom (Var (s, _)) when s = String.concat "" [ "strlen"; v ] -> true*)
           | _ -> acc)
        (fun acc _ -> acc)
        false
        eia
    in
    let rec in_strlen v ast =
      match ast with
      | True | Pred _ -> false
      | Eia eia ->
        begin match eia with
        | Eia.RLen (Eia.Atom (Var (s, _)), _) when s = v -> true
        | _ -> in_strlen_eia v eia
        end
      | Lnot ast' | Exists (_, ast') -> in_strlen v ast'
      | Land asts | Lor asts ->
        List.fold_left (fun acc ast -> acc || in_strlen v ast) false asts
      | Unsupp _ -> false
    in
    let rec in_in_re_rawi v ast =
      match ast with
      | True | Pred _ -> false
      | Eia (InReRaw (Ast.Eia.Atom (Ast.Var (v, I)), I, _)) -> true
      | Eia _ -> false
      | Lnot ast' | Exists (_, ast') -> in_in_re_rawi v ast'
      | Land asts | Lor asts ->
        List.fold_left (fun acc ast -> acc || in_in_re_rawi v ast) false asts
      | Unsupp _ -> false
    in
    let var_can_subst v =
      Env.is_absent_key v env
      && not
           (String.starts_with ~prefix:"strlen" v
            && Ast.forsome
                 (function
                   | Ast.Eia eia ->
                     Ast.Eia.fold2
                       (fun acc -> function
                          | Ast.Eia.Pow (_, Ast.Eia.Atom (Ast.Var (v', Ast.I)))
                            when v = v' -> true
                          | _ -> acc)
                       (fun acc _ -> acc)
                       false
                       eia
                   | _ -> false)
                 orig_ast)
    in
    let var_can_subst_complex v =
      var_can_subst v && (not (in_strlen v orig_ast)) && not (in_in_re_rawi v orig_ast)
    in
    let single =
      fun info env c1 (Var (vn1, _) as v1) c2 (Var (vn2, _) as v2) rhs ->
      let is_bad v =
        (not (var_can_subst_complex v))
        || Info.is_in_expo v info
        || Info.is_in_string v info
      in
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
    | Eia (Eia.Eq (Atom (Var (vn, _) as v), (Str_const str as rhs), S))
      when var_can_subst vn ->
      (* (= v 'str') *)
      Some (extend_exn env v rhs)
    | Eia (Eia.Eq ((Str_const str as rhs), Atom (Var (vn, S) as v), S))
      when var_can_subst vn ->
      (* (= 'str' v) *)
      Some (extend_exn env v rhs)
    (* GB: These substitutions are too aggressive: it is possible to remember
           that <var 1> = str.len <var 2> but do not substitue RHS instead of
           <var 1>. Then the answer would be different since the connection
           between <var 1> and <var 2> is lost. *)
    | Eia (Eia.Eq (Atom (Var (vn, _) as v), (Eia.Sofi (Atom (Var _)) as rhs), _))
      when var_can_subst vn -> safe_extend_exn env v rhs
    | Eia (Eia.Eq (Atom (Var (vn, _) as v), rhs, S)) when var_can_subst vn ->
      safe_extend_exn env v rhs
    | Eia (Eia.Eq (lhs, Atom (Var (vn, _) as v), S)) when var_can_subst vn ->
      safe_extend_exn env v lhs
    | Eia (Eia.Eq (Atom (Var (vn, _) as v), (Eia.Iofs (Atom (Var _)) as rhs), _))
      when var_can_subst vn -> safe_extend_exn env v rhs
    | Eia (Eia.Eq (Atom (Var (vn, _) as v), (Eia.Len (Atom (Var _)) as rhs), _))
      when var_can_subst vn -> Some (extend_exn env v rhs)
    | Eia (Eia.Eq (Atom (Var (vn, _) as v), (Eia.Len2 (Atom (Var _)) as rhs), _))
      when var_can_subst vn -> Some (extend_exn env v rhs)
    | Eia (Eia.Eq (Eia.Sofi (Atom (Var (vn, _))), Eia.Sofi (Atom (Var _) as rhs), _))
      when var_can_subst vn -> Some (Env.extend_int_exn env vn rhs)
    (* Kakadu: it is not lost, it is saved in the environment.
      We need to decide how to handle it properly  *)
    (* **************************** integer stuff *********************************** *)
    | Eia
        (Eia.Eq ((Atom (Var (vn1, _) as v1) as lhs), (Atom (Var (vn2, _) as v2) as rhs), _))
      ->
      (match var_can_subst_complex vn1, var_can_subst_complex vn2 with
       | true, other ->
         if Env.occurs_var env vn1 rhs then None else Some (extend_exn env v1 rhs)
       | false, true ->
         if Env.occurs_var env vn2 lhs then None else Some (extend_exn env v2 lhs)
       | false, false -> None)
    | Eia (Eia.Eq (Atom (Var (vn, I) as v1), (Const c as rhs), I))
    | Eia (Eia.Eq ((Const c as rhs), Atom (Var (vn, I) as v1), I))
      when var_can_subst vn ->
      (* (= v c) *)
      Some (extend_exn env v1 rhs)
    | Eia (Eia.Eq (Mul [ Const _; Atom (Var (vn, _) as v) ], (Const z as rhs), _))
    | Eia (Eia.Eq ((Const z as rhs), Mul [ Const _; Atom (Var (vn, _) as v) ], _))
      when Z.(equal z zero) && var_can_subst vn ->
      (* (= ( * c v) 0) *)
      Some (extend_exn env v rhs)
    | Eia (Eia.Eq (Mul [ Const cl; Atom (Var (vn, _) as v) ], Const cr, _))
    | Eia (Eia.Eq (Const cr, Mul [ Const cl; Atom (Var (vn, _) as v) ], _))
      when Z.(cr mod cl = zero) && var_can_subst_complex vn ->
      let rhs = Eia.(Const Z.(cr / cl)) in
      Some (extend_exn env v rhs)
    | Eia (Eia.Eq (Mul [ Const cl; Len (Atom (Var (vn, _) as v)) ], Const cr, I))
    | Eia (Eia.Eq (Const cr, Mul [ Const cl; Len (Atom (Var (vn, _) as v)) ], I))
      when Z.(cr = zero) && Z.(cl <> zero) && var_can_subst vn ->
      Some (extend_exn env v (Id_symantics.str_const ""))
    | Eia (Eia.Eq (Len (Atom (Var (vn, _) as v)), Const cr, I))
    | Eia (Eia.Eq (Const cr, Len (Atom (Var (vn, _) as v)), I))
      when Z.(cr = zero) && var_can_subst vn ->
      Some (extend_exn env v (Id_symantics.str_const ""))
    | Eia (Eia.Eq (Atom (Var (vn, I) as vr), Mul [ Const cl; Atom (Var (vn2, I)) ], I))
    | Eia (Eia.Eq (Mul [ Const cl; Atom (Var (vn, I)) ], Atom (Var (vn2, I) as vr), I))
      when vn == vn2 && var_can_subst vn ->
      (* (= ( * c v) vr) *)
      Some (extend_exn env vr (Const Z.zero))
    | Eia
        (Eia.Eq
           ( Mul [ Const cl; Atom (Var (vn, I) as vr) ]
           , Mul [ Const cl2; Atom (Var (vn2, I)) ]
           , I ))
      when vn == vn2 && cl <> cl2 && var_can_subst vn ->
      Some (extend_exn env vr (Const Z.zero))
    (* | Eia
        (Eia.Eq
           (Atom (Var (vn2, I) as vr), (Mul [ Const cl; Atom (Var (_, I)) ] as lhs), I))
    | Eia
        (Eia.Eq
           ((Mul [ Const cl; Atom (Var (_, I)) ] as lhs), Atom (Var (vn2, I) as vr), I))
      when var_can_subst vn2 ->
      (* (= ( * c v) vr) *)
      Some (extend_exn env vr lhs) *)
    | Eia
        (Eia.Eq
           ( Add
               [ Atom (Var (v1n, _) as v1); Mul [ Const c; (Atom (Var (v2n, _)) as v2) ] ]
           , Const z0
           , I ))
    | Eia
        (Eia.Eq
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
          if Z.(equal c minus_one) then v2 else Eia.Mul [ Const Z.(-c); v2 ]
        in
        Some (extend_exn env v1 new_rhs))
    | Eia (Eia.Eq (Add [ Atom (Var (_, I) as v1); Atom (Var (_, I) as v2) ], rhs, I))
      when v1 <> v2 ->
      (* (= (+ v1 v2) rhs) *)
      (* log "%s %d. ast = %a" __FILE__ __LINE__ Ast.pp_smtlib2 ast; *)
      single info env Z.one v1 Z.one v2 rhs
    | Eia
        (Eia.Eq
           ( Add [ Atom (Var (vn1, _) as v1); Mul [ Const c2; Atom (Var (vn2, _) as v2) ] ]
           , rhs
           , I ))
      when vn1 <> vn2 ->
      (* (= (+ v1 ( * c v2)) rhs) *)
      single info env Z.one v1 c2 v2 rhs
    | Eia
        (Eia.Eq
           ( Add [ Mul [ Const c1; Atom (Var (vn1, _) as v1) ]; Atom (Var (vn2, _) as v2) ]
           , rhs
           , I ))
      when vn1 <> vn2 ->
      (* (= (+ ( * c v1) v2) rhs) *)
      single info env c1 v1 Z.one v2 rhs
    | Eia
        (Eia.Eq
           ( Add
               [ Mul [ Const c1; Atom (Var (vn1, _) as v1) ]
               ; Mul [ Const c2; Atom (Var (vn2, _) as v2) ]
               ]
           , rhs
           , I ))
      when vn1 <> vn2 -> single info env c1 v1 c2 v2 rhs
    | Eia (Eia.Eq (Add sums, Const rhs, I)) when Z.(zero = rhs) ->
      (* (= (+ ...) 0) *)
      let not_touched_by_env env term =
        try
          let f env = function
            | Eia.Atom (Var (v, _)) when not (Env.is_absent_key v env) -> raise Exit
            | _ -> env
          in
          let _ : Env.t = Eia.fold_term f (fun acc _ -> acc) env term in
          true
        with
        | Exit -> false
      in
      let maybe_extend env vn v data ~fk =
        if not (Env.occurs_var env vn data) then extend_exn env v data else fk ()
      in
      let is_bad v = Info.is_in_expo v info || Info.is_in_string v info in
      let rec loop acc = function
        | Eia.Atom (Var (v, _)) :: _ when not (Env.is_absent_key v env) -> raise Exit
        | Eia.Atom (Var (vn, _) as v) :: xs
          when var_can_subst_complex vn && not (is_bad vn) ->
          let data = S.(mul [ constz Z.minus_one; add (acc @ xs) ]) in
          maybe_extend env vn v data ~fk:(fun () -> loop (Eia.Atom v :: acc) xs)
        | (Mul [ Const c; Eia.Atom (Var (vn, _) as v) ] as leftmost) :: xs
          when var_can_subst_complex vn
               && (not (is_bad vn))
               && Z.(equal (of_int (-1)) c)
               && not_touched_by_env env (Eia.Add acc)
               && not_touched_by_env env (Eia.Add xs) ->
          let data = S.(mul [ add (acc @ xs) ]) in
          maybe_extend env vn v data ~fk:(fun () -> loop (leftmost :: acc) xs)
        | h :: tl -> loop (h :: acc) tl
        | [] -> raise Exit
      in
      (try Some (loop [] sums) with
       | Exit -> None)
    | Eia (Eia.Eq (Atom (Var (vn, _)), rhs, _))
      when match rhs with
           | Bwand _ | Bwor _ | Bwxor _ -> true
           | _ -> false -> None
    | Eia (Eia.Eq (Atom (Var (vn, _) as v), rhs, _) as eia')
      when (not (Env.occurs_var env vn rhs))
           && var_can_subst_complex vn
           && Ast.forsome
                (function
                  | Eia eia'' when eia' <> eia'' && Set.mem (get_atoms eia'') vn -> true
                  | _ -> false)
                orig_ast -> Some (extend_exn env v rhs)
    (*| Eia (Eia.Eq (Add terms, rhs, I) as eia')
      when
        List.exists (function
        | Ast.Eia.Mul ([Ast.Eia.Const c; Atom (Var (vn, _))])
        | Ast.Eia.Mul ([Atom (Var (vn, _)); Ast.Eia.Const c])
        when c = Z.minus_one -> Ast.forsome
              (function
                | Eia eia'' when eia' <> eia'' && Set.mem (get_atoms eia'') vn -> true
                | _ -> false) orig_ast
        | _ -> false) terms ->
        let aux = function
        | Ast.Eia.Mul ([Ast.Eia.Const c; Atom (Var (vn, _) as v)])
        | Ast.Eia.Mul ([Atom (Var (vn, _) as v); Ast.Eia.Const c])
        when c = Z.minus_one -> if Ast.forsome
              (function
                | Eia eia'' when eia' <> eia'' && Set.mem (get_atoms eia'') vn -> true
                | _ -> false) orig_ast then Option.some v else None
        | _ -> None in
        let v = List.find_map aux terms |> Option.get in
        let rhs = Ast.Eia.add (Ast.Eia.Mul [Id_symantics.constz Z.minus_one; rhs] :: (List.filter (fun term -> aux term |> Option.is_none) terms)) in
        Some (extend_exn env v rhs)*)
    | Eia (Eia.Eq (lhs, Atom (Var (vn, _)), _))
      when match lhs with
           | Bwand _ | Bwor _ | Bwxor _ -> true
           | _ -> false -> None
    | Eia (Eia.Eq (lhs, Atom (Var (vn, _) as v), _) as eia')
      when var_can_subst_complex vn
           && (function
                | Eia eia'' when eia' <> eia'' && Set.mem (get_atoms eia'') vn -> true
                | _ -> false)
                orig_ast -> Some (extend_exn env v lhs)
    | eq ->
      (* log "OTHERWISE  ast part = @[%a@]" Ast.pp_smtlib2 ast; *)
      None
    (* None means left as it is *)
  in
  fun info ?multiple env ast ->
    let multiple = Option.value ~default:false multiple in
    match ast with
    | Land xs ->
      let env', ys = fold_and_filter multiple (helper info ast) env xs in
      let ans_ph = if ys = [] && xs <> [] then True else Ast.land_ ys in
      env', ans_ph
    | Eia _ ->
      (match helper info ast env ast with
       | Some e -> e, Ast.True
       | None -> env, ast)
    | ph -> env, ph
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ?(env = [ "x"; "y"; "z" ]) ?(exp = []) ph =
    let info = Info.make ~all:env ~exp ~str:[] in
    let env2, _ = eq_propagation info Env.empty ph in
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
      let zz = Ast.Eia.(Const z) in
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
  let str_len s = s
  let sofi s = s
  let iofs s = s
  let str_const s = String.to_seq s |> List.of_seq |> S.of_list

  let str_var v =
    (* Format.printf "%s %d: %s\n%!" __FUNCTION__ __LINE__ v; *)
    empty
  ;;

  let str_from_eia_const s = empty
  let str_concat = ( ++ )
  let const _ = empty
  let constz _ = empty
  let var s = empty

  let str_len2 v =
    (* Format.printf "%s %d: %s\n%!" __FUNCTION__ __LINE__ v; *)
    v
  ;;

  let pp_str fmt ph = Format.fprintf fmt "todo"
  let str_at _ _ = empty
  let str_substr _ _ _ = empty
  let str_prefixof = ( ++ )
  let str_contains = ( ++ )
  let str_suffixof = ( ++ )

  let mul xs =
    let aaa = List.fold_left ( ++ ) empty xs in
    (* let u2 =
      match xs with
      | [ Eia.Atom (Var (v,_)); Eia.Pow (Eia.  (Const 2), Eia.Atom (Var _)) ] ->
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
  let eq_str = ( ++ )
  let neq_str = ( ++ )
  let leq = ( ++ )
  let lt = ( ++ )
  let pow_minus_one x = x
  let rlen = ( ++ )

  let exists _ info =
    (* This place could be buggy when name clashes  *)
    info
  ;;

  let pow2var v = empty
  let pow = ( ++ )
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
    (* log "Ast after main_symantics: @[%a@]" Ast.pp_smtlib2 ast2; *)
    (* let ast2 = ast2 |> propagate_exponents |> shrink_variables in *)
    let ast2 = propagate_exponents ast2 in
    let __ _ = trace_log "Ast after propagate_exponents: @[%a@]" Ast.pp_smtlib2 ast2 in
    let var_info = apply_symantics (module Who_in_exponents) ast in
    (* Format.printf "%s: info = @[%a@]\n%!" __FUNCTION__ Info.pp_hum var_info; *)
    let env2, ast2 = eq_propagation var_info ?multiple env ast2 in
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
       | _ -> ast2, env, var_info, step)
  in
  try `Unknown (loop step env ast) with
  | Unsat -> `Unsat
  | Sat (_, env) -> `Sat env
;;

let run_basic_simplify ?(env = Env.empty) ast =
  trace_log "Basic simplifications...";
  let ast = lower_mod ast in
  let __ _ = trace_log "After strlen lowering:@,@[%a@]" Ast.pp_smtlib2 ast in
  if Ast.is_conjunct ast
  then (
    match basic_simplify [ 1 ] env ast with
    | `Sat env -> `Sat ("presimpl int", env)
    | `Unsat -> `Unsat
    | `Unknown (ast, e, _, _) -> `Unknown (ast, e))
  else `Unknown (ast, Env.empty)
;;

let collect_regexes ast =
  let module NfaL = Nfa.Lsb (Nfa.Str) in
  let module Map = Base.Map.Poly in
  let open Ast in
  fold
    (fun acc -> function
       (* | Ast.Eia (Eq (lhs, Ast.Eia.Str_const str, S)) -> Ast.Eia.in_re TODO *)
       | Eia (Eq (Eia.Atom (Ast.Var (s, S)), Eia.Str_const str, S)) ->
         (s, Regex.str_to_re str |> NfaL.of_regex) :: acc
       | Eia (Eq (Eia.Str_const str, Eia.Atom (Var (s, S)), S)) ->
         (s, Regex.str_to_re str |> NfaL.of_regex) :: acc
       (* | Eia (Eq (Eia.Iofs (Eia.Atom (Var (s, S))), Eia.Const n, I)) ->
         (s, Regex.int_to_re (Z.to_string n) |> NfaL.of_regex) :: acc
       | Eia (Eq (Eia.Const n, Eia.Iofs (Eia.Atom (Var (s, S))), I)) ->
         (s, Regex.int_to_re (Z.to_string n) |> NfaL.of_regex) :: acc *)
       | Eia (InRe (Eia.Atom (Var (s, S)), S, re)) -> (s, re |> NfaL.of_regex) :: acc
       | Eia (InReRaw (Eia.Atom (Var (s, S)), S, nfa)) -> (s, nfa) :: acc
       | Eia (InReRaw (Eia.Atom (Var (s, I)), I, nfa)) -> (s, nfa) :: acc
       | _ -> acc)
    []
    ast
  |> Map.of_alist_multi
;;

let subst env ast =
  let (module S : SYM_SUGAR_AST) = make_main_symantics ~agressive:true env in
  apply_symantics_unsugared (module S) ast
;;

let arithmetize ast env =
  let module Set = Base.Set.Poly in
  (*let exception StrVar_In_Arithmetize in*)
  let strlens s = String.concat "" [ "strlen"; s ] in
  let pow_base = Ast.Eia.pow (Ast.Eia.const Config.config.enc_base) in
  (* let in_stoi2 v = Ast.in_stoi2 v ast in *)
  let atomi v = Ast.Eia.Atom (Ast.Var (v, Ast.I)) in
  let module NfaL = Nfa.Lsb (Nfa.Str) in
  let module NfaCL = NfaCollection.LsbStr in
  let module Map = Base.Map.Poly in
  let is_regex : Ast.t -> bool = function
    | Ast.Eia (Eq (Ast.Eia.Atom (Ast.Var (s, S)), Ast.Eia.Str_const _, S))
    | Ast.Eia (InRe (Ast.Eia.Atom (Ast.Var (s, S)), Ast.S, _))
    | Ast.Eia (InReRaw (Ast.Eia.Atom (Ast.Var (s, S)), Ast.S, _))
    | Ast.Eia (InReRaw (Ast.Eia.Atom (Ast.Var (s, I)), Ast.I, _)) -> true
    | _ -> false
  in
  let fold_regexes ?(str_vars = []) ast =
    let open Ast in
    let extra =
      Ast.get_stoi_conc_vars ast
      |> List.map (fun var ->
        if List.mem var str_vars then var, Regex.nondigit else var, Regex.digit)
      |> List.map (fun (var, regex) ->
        eia (Eia.inre (Eia.Atom (Var (var, S))) Ast.S regex))
      |> land_
    in
    let fold_regexes collected =
      Map.mapi
        ~f:(fun ~key:var ~data ->
          List.fold_left (fun acc nfa -> NfaS.intersect nfa acc) (NfaCL.n ()) data)
        collected
    in
    let model_regexes = Ast.land_ [ ast; extra ] |> collect_regexes |> fold_regexes in
    let regexes = ast |> collect_regexes |> fold_regexes in
    let ast_without_regex =
      Ast.map
        (function
          | ast when is_regex ast -> Ast.true_
          | ast -> ast)
        ast
    in
    let phs =
      if Map.existsi ~f:(fun ~key ~data -> NfaS.run data |> not) model_regexes
      then [ Ast.false_ ]
      else
        Map.fold
          ~init:[]
          ~f:(fun ~key:s ~data:nfa ph ->
            Ast.Eia (InReRaw (Ast.Eia.Atom (Ast.Var (s, S)), Ast.S, nfa)) :: ph)
          regexes
    in
    let ast = Ast.land_ (ast_without_regex :: phs) in
    ast, model_regexes
  in
  let fold_regexes_i ast =
    let regexes =
      Map.map
        ~f:(fun data ->
          List.fold_left
            (fun acc nfa -> NfaS.intersect nfa acc)
            (NfaCollection.LsbStr.n ())
            data)
        (Ast.fold
           (fun acc -> function
              | Ast.Eia (InReRaw (Ast.Eia.Atom (Ast.Var (s, I)), Ast.I, nfa)) ->
                (s, nfa) :: acc
              | _ -> acc)
           []
           ast
         |> Map.of_alist_multi)
    in
    let ast_without_regex =
      Ast.map
        (function
          | ast when is_regex ast -> Ast.true_
          | ast -> ast)
        ast
    in
    let phs =
      if Map.existsi ~f:(fun ~key ~data -> NfaS.run data |> not) regexes
      then [ Ast.false_ ]
      else
        Map.fold
          ~init:[]
          ~f:(fun ~key:s ~data:nfa ph ->
            Ast.Eia (InReRaw (Ast.Eia.Atom (Ast.Var (s, I)), Ast.I, nfa)) :: ph)
          regexes
    in
    Ast.land_ (ast_without_regex :: phs), regexes
  in
  let flatten ast =
    let extra_ph = ref [] in
    let extends v other =
      extra_ph := Id_symantics.eq_str (Id_symantics.str_var v) other :: !extra_ph
    in
    let module M_ = struct
      include Id_symantics

      let str_len = function
        | Ast.Eia.Atom _ as v -> Id_symantics.str_len v
        | non_var ->
          let v = gensym ~prefix:"%arith_flat" () in
          extends v non_var;
          Id_symantics.str_len (Ast.Eia.atom (Ast.var v Ast.S))
      ;;

      let prj = function
        | Ast.Land xs -> land_ (!extra_ph @ xs)
        | ph -> land_ (!extra_ph @ [ ph ])
      ;;
    end
    in
    apply_symantics_unsugared (module M_) ast
  in
  let arithmetize_concats { Info.all; _ } str_vars =
    let module Map = Base.Map.Poly in
    let exception Unsupp_concat of string in
    let gensym1 = gensym in
    let rec gensym () =
      let ans = gensym1 ~prefix:"%concat" () in
      if Base.Set.Poly.mem all ans then gensym () else ans
    in
    let extra_ph = ref [] in
    let extend v other =
      extra_ph := Id_symantics.eqz (Id_symantics.var v) other :: !extra_ph
    in
    let extend2 v strv =
      extra_ph
      := match strv with
           | Ast.Eia.Atom (Ast.Var (s, S)) when List.mem s str_vars ->
             raise (Unsupp_concat ("str var " ^ s))
           | _ ->
             Id_symantics.eqz (Id_symantics.var v) (Ast.Eia.Iofs strv)
             :: Id_symantics.leq (Ast.Eia.Const Z.zero) (Ast.Eia.Iofs strv)
             :: !extra_ph
    in
    let extend_unsupp s =
      extra_ph := Id_symantics.unsupp (s ^ " in unsupported concat") :: !extra_ph
    in
    let module ArConcIofs = struct
      include Id_symantics

      let iofs =
        let contains_var vars =
          Ast.Eia.fold_term
            (fun acc el -> acc)
            (fun acc el ->
               match el with
               | Ast.Eia.Atom (Var (s, S)) when List.mem s vars -> true
               | Ast.Eia.Concat (_, Ast.Eia.Atom (Var (s, S))) when List.mem s vars ->
                 true
               | Ast.Eia.Concat (Ast.Eia.Atom (Var (s, S)), _) when List.mem s vars ->
                 true
               | _ -> acc)
            false
        in
        function
        | s when contains_var str_vars s -> Id_symantics.constz Z.minus_one
        | s -> Id_symantics.iofs s
      ;;
    end
    in
    let module ArConc = struct
      include Id_symantics

      let str_concat (lhs : str) (rhs : str) =
        let handle_concat (lhs : str) (rhs : str) =
          let u = gensym () in
          let v = gensym () in
          let lhs' = gensym () in
          let rhs' = gensym () in
          extend2 lhs' lhs;
          extend2 rhs' rhs;
          extend
            u
            (Ast.Eia.add
               [ Ast.Eia.mul [ Ast.Eia.Atom (Ast.var lhs' I); pow2var v ]
               ; Ast.Eia.atom (Ast.var rhs' I)
               ]);
          extend v (Ast.Eia.len rhs);
          Ast.Eia.sofi (Ast.Eia.Atom (Ast.var u I))
        in
        let rec do_concat lhs rhs =
          match lhs, rhs with
          | Ast.Eia.Concat (lhs1, rhs1), Ast.Eia.Concat (lhs2, rhs2) ->
            do_concat (do_concat lhs1 rhs1) (do_concat lhs1 rhs1)
          | Ast.Eia.Concat (lhs1, rhs1), rhs2 -> handle_concat (do_concat lhs1 rhs1) rhs2
          | lhs1, Ast.Eia.Concat (lhs2, rhs2) -> handle_concat lhs1 (do_concat lhs2 rhs2)
          | lhs1, rhs1 ->
            (match lhs1, rhs1 with
             | Ast.Eia.Str_const s, _
               when String.for_all Base.Char.is_digit s |> Stdlib.not ->
               raise (Unsupp_concat s)
             | _, Ast.Eia.Str_const s
               when String.for_all Base.Char.is_digit s |> Stdlib.not ->
               raise (Unsupp_concat s)
             | lhs1, rhs1 -> handle_concat lhs1 rhs1)
        in
        try do_concat lhs rhs with
        | Unsupp_concat s ->
          extend_unsupp s;
          let unsupp = gensym () in
          Ast.Eia.sofi (Ast.Eia.Atom (Ast.var unsupp I))
      ;;

      let prj = function
        | Ast.Land xs -> land_ (!extra_ph @ xs)
        | ph -> land_ (!extra_ph @ [ ph ])
      ;;
    end
    in
    let module SymArConcIofs = struct
      include ArConcIofs
      include FT_SIG.Sugar (ArConcIofs)
    end
    in
    let module SymArConc = struct
      include ArConc
      include FT_SIG.Sugar (ArConc)
    end
    in
    fun ph ->
      SymArConc.prj
        (ph
         |> apply_symantics (module SymArConcIofs)
         |> apply_symantics (module SymArConc))
  in
  let arithmetize var_info str_vars ast =
    let (module M) = make_main_symantics Env.empty in
    let in_stoi v = Ast.in_stoi v ast in
    let in_regex v = Map.mem (collect_regexes ast) v in
    let open Ast.Eia in
    let in_stoi_or_concat v = Ast.in_stoi v ast || Ast.in_concat v ast in
    let rec arithmetize_term : 'a. string list -> 'a term -> Z.t term * Ast.Eia.t list =
      fun (type a) : (string list -> a term -> Z.t term * Ast.Eia.t list) -> function
        | str_vars ->
          (function
            | Sofi s -> arithmetize_term str_vars s
            | Iofs (Atom (Var (v, S))) when List.mem v str_vars -> const Z.minus_one, []
            | Iofs (Atom (Var (v, S))) -> atomi v, [ leq (const Z.zero) (atomi v) ]
            | Iofs s -> arithmetize_term str_vars s
            | Len (Atom (Var (var, S))) ->
              let lenvar, phs = String.concat "" [ "strlen"; var ], [] in
              let v = atomi lenvar in
              let phs =
                (if in_stoi_or_concat var && not (List.mem var str_vars)
                 then leq (const Z.one) v
                 else leq (const Z.zero) v)
                :: phs
              in
              let phs =
                if List.mem var str_vars
                then phs
                else (
                  match in_stoi var, in_regex var with
                  | true, true -> rlen (atomi var) (pow_base v) :: phs
                  | true, false -> lt (atomi var) (pow_base v) :: phs
                  | false, other -> phs)
              in
              v, phs
            | Len term ->
              let term', phs = arithmetize_term str_vars term in
              let lenvar, phs =
                Format.asprintf "strlen_%a" Ast.pp_term_smtlib2 term', []
              in
              let v = atomi lenvar in
              let phs = leq (Ast.Eia.const Z.zero) v :: phs in
              let phs =
                leq (pow_base v) term'
                :: lt term' (Mul [ const Config.config.enc_base; pow_base v ])
                :: phs
              in
              v, phs
            | Str_const s -> const (Z.of_string s), []
            | Atom (Var (v, S)) -> atomi v, []
            | Concat (_, _) | At (_, _) | Substr (_, _, _) ->
              failwith "Unexpected function in arithmetize_term"
            | (Const _ | Atom (Var (_, I))) as eia -> eia, []
            | Add ls ->
              let ls, phs =
                List.map (fun x -> arithmetize_term str_vars x) ls |> List.split
              in
              add ls, List.concat phs
            | Mul ls ->
              let ls, phs =
                List.map (fun x -> arithmetize_term str_vars x) ls |> List.split
              in
              mul ls, List.concat phs
            | Mod (lhs, rhs) ->
              let lhs, lhs_phs = arithmetize_term str_vars lhs in
              mod_ lhs rhs, lhs_phs
            | (Pow (lhs, rhs) | Bwand (lhs, rhs) | Bwor (lhs, rhs) | Bwxor (lhs, rhs)) as
              eia ->
              let build =
                match eia with
                | Pow _ -> pow
                | Bwand _ -> bwand
                | Bwor _ -> bwor
                | Bwxor _ -> bwxor
                | _ -> assert false
              in
              let lhs, lhs_phs = arithmetize_term str_vars lhs in
              let rhs, rhs_phs = arithmetize_term str_vars rhs in
              build lhs rhs, lhs_phs @ rhs_phs
            | term ->
              failwith
                (Format.asprintf
                   "Unexpected in arithmetize_term: %a"
                   Ast.Eia.pp_term
                   term))
    in
    let arithmetize_in_re s nfa =
      trace_log "Arithmetizing regex ...";
      Debug.dump_nfa ~msg:"for NFA %s" NfaS.format_nfa nfa;
      let strlens = strlens s in
      let csds =
        let is_eos vec =
          match Array.length vec with
          | 1 -> Char.equal (Array.get vec 0) Nfa.Str.u_eos
          | _ -> failwith "unexpected nfa in arithmetize_in_re"
        in
        NfaL.filter_map nfa (fun (label, q') ->
          if is_eos label then Option.none else Option.some (label, q'))
        |> NfaL.to_nat
        |> NfaL.chrobak
      in
      let const = Ast.Eia.const in
      csds
      |> Seq.map (fun (c, d) ->
        let c, d = Z.of_int c, Z.of_int d in
        let n = gensym ~prefix:"%re_len" () in
        Ast.land_
          [ Ast.eia (Ast.Eia.leq (const Z.zero) (atomi n))
          ; Ast.eia
              (Ast.Eia.eq
                 (atomi strlens)
                 (Ast.Eia.add [ const c; Ast.Eia.mul [ const d; atomi n ] ])
                 Ast.I)
          ])
      |> List.of_seq
    in
    let cartesian l1 l2 =
      List.concat (List.map (fun e1 -> List.map (fun e2 -> Ast.land_ [ e1; e2 ]) l2) l1)
    in
    let rec arithmetize_conj str_vars = function
      | Ast.Land [ x ] -> arithmetize_conj str_vars x
      | Ast.Land (x :: xs) ->
        List.fold_left
          cartesian
          (arithmetize_conj str_vars x)
          (List.map (fun x -> arithmetize_conj str_vars x) xs)
      | Ast.Eia (Leq (lhs, rhs)) ->
        let lhs', lhs_phs = arithmetize_term str_vars lhs in
        let rhs', rhs_phs = arithmetize_term str_vars rhs in
        [ Ast.land_ (Ast.Eia.leq lhs' rhs' :: (lhs_phs @ rhs_phs) |> List.map Ast.eia) ]
      | Ast.Eia (Eq (lhs, rhs, I)) ->
        let lhs', lhs_phs = arithmetize_term str_vars lhs in
        let rhs', rhs_phs = arithmetize_term str_vars rhs in
        [ Ast.land_ (Ast.Eia.eq lhs' rhs' Ast.I :: (lhs_phs @ rhs_phs) |> List.map Ast.eia)
        ]
      | Ast.Eia (Eq (lhs, rhs, S)) ->
        let lhs', lhs_phs = arithmetize_term str_vars lhs in
        let rhs', rhs_phs = arithmetize_term str_vars rhs in
        [ Ast.land_ (Ast.Eia.eq lhs' rhs' Ast.I :: (lhs_phs @ rhs_phs) |> List.map Ast.eia)
        ]
      | Ast.Eia (InRe (s, Ast.S, re)) -> failwith "Unexpected InRe in arithmetize_conj"
      | Ast.Eia (InReRaw (s, S, nfa)) ->
        let s, phs = arithmetize_term str_vars s in
        let s, phs =
          match s with
          | Ast.Eia.Atom (Var (s, I)) -> s, phs
          | non_var ->
            let v = gensym ~prefix:"%arith_re_raw" () in
            v, Ast.Eia.eq (atomi v) non_var Ast.I :: phs
        in
        let nfa =
          if not (in_stoi_or_concat s)
          then nfa
          else if List.mem s str_vars
          then Regex.nondigit |> NfaS.of_regex |> NfaS.intersect nfa
          else Regex.digit |> NfaS.of_regex |> NfaS.intersect nfa
        in
        (match in_stoi_or_concat s, List.mem s str_vars with
         | true, false ->
           Ast.Eia (Ast.Eia.inreraw (atomi s) Ast.I nfa) :: (phs |> List.map Ast.eia)
         | _ ->
           arithmetize_in_re s nfa
           |> List.map (fun ast' -> Ast.land_ (ast' :: (phs |> List.map Ast.eia))))
      | Ast.Eia (PrefixOf _ | SuffixOf _ | Contains _) -> failwith "Unexpected constraint"
      | Ast.Unsupp s -> [ Ast.Unsupp s ]
      | _ as non_eia -> [ non_eia ]
    in
    let var_appears_as_string_eia v eia =
      Ast.Eia.fold2
        (fun acc el ->
           match el with
           | Ast.Eia.Atom (Var (s, _)) when s = String.concat "" [ "string"; v ] -> true
           | _ -> acc)
        (fun acc el ->
           match el with
           | Ast.Eia.Atom (Var (s, _)) when s = String.concat "" [ "string"; v ] -> true
           | _ -> acc)
        false
        eia
      |> fun res -> res
    in
    let rec var_appears_as_string v ast =
      (match ast with
       | Ast.True | Pred _ -> false
       | Eia eia -> var_appears_as_string_eia v eia
       | Lnot ast' | Exists (_, ast') -> var_appears_as_string v ast'
       | Land asts | Lor asts ->
         List.fold_left (fun acc ast -> acc || var_appears_as_string v ast) false asts
       | Unsupp _ -> false)
      |> fun res -> res
    in
    arithmetize_concats var_info str_vars ast
    |> apply_symantics_unsugared (module M)
    |> arithmetize_conj str_vars
    |> List.map (fun ast ->
      Ast.map
        (function
          | Ast.Eia (Ast.Eia.RLen (Ast.Eia.Atom (Ast.Var (s, _)), rhs))
            when var_appears_as_string s ast ->
            Ast.eia
              (Ast.Eia.rlen
                 (Ast.Eia.atom (Ast.Var (String.concat "" [ "string"; s ], Ast.I)))
                 rhs)
          | ast -> ast)
        ast)
  in
  let unfold_neq var_info regexes ast =
    let strlen_var s = String.concat "" [ "strlen"; s ] in
    let strleni s = Ast.Eia.Atom (Ast.Var (strlen_var s, Ast.I)) in
    let get_len v =
      Ast.fold
        (fun acc -> function
           | Eia (Eq (Atom (Var (s, _)), Const c, I)) when s = strlen_var v -> Z.max c acc
           | Eia (Eq (Const c, Atom (Var (s, _)), I)) when s = strlen_var v -> Z.max c acc
           | _ -> acc)
        Z.minus_one
        ast
      |> Z.to_int
    in
    let ast_if cond ast = if cond then ast else Ast.false_ in
    let aux (f : string -> string -> Ast.t) =
      Ast.map (function
        | Ast.Eia
            (Ast.Eia.Neq
               ( Ast.Eia.Atom (Ast.Var (lhs, Ast.S))
               , Ast.Eia.Atom (Ast.Var (rhs, Ast.S))
               , Ast.S )) -> f lhs rhs
        | ast -> ast)
    in
    let can_be_both_digit lhs rhs =
      let lhs_re =
        Map.find regexes lhs |> Option.map (NfaL.intersect (NfaL.of_regex Regex.digit))
      in
      let rhs_re =
        Map.find regexes rhs |> Option.map (NfaL.intersect (NfaL.of_regex Regex.digit))
      in
      match lhs_re, rhs_re with
      | Some lhs_re, Some rhs_re -> lhs_re |> NfaL.run && rhs_re |> NfaL.run
      | Some re, None | None, Some re -> NfaL.run re
      | None, None -> true
    in
    let posts = ref Map.empty in
    let asts =
      ast
      |> aux (fun lhs rhs ->
        let ast1 = Ast.eia (Ast.Eia.neq (strleni lhs) (strleni rhs) Ast.I) in
        let ast2 =
          let ast =
            Ast.land_
              [ Ast.eia (Ast.Eia.eq (strleni lhs) (strleni rhs) Ast.I)
              ; Ast.eia (Ast.Eia.neq (atomi lhs) (atomi rhs) Ast.I)
              ]
          in
          ast_if (can_be_both_digit lhs rhs) ast
        in
        (* The third case: they are both non-digit strings of the same length; to_int is -1*)
        let ast3 =
          let lhs_re =
            Map.find regexes lhs
            |> Option.map (NfaL.intersect (NfaL.of_regex Regex.nondigit))
            |> Option.value ~default:(NfaCL.n ())
          in
          let rhs_re =
            Map.find regexes rhs
            |> Option.map (NfaL.intersect (NfaL.of_regex Regex.nondigit))
            |> Option.value ~default:(NfaCL.n ())
          in
          let length_check length =
            if length > 0
            then (
              let w1 = NfaS.all_paths_of_len lhs_re length in
              let w2 = NfaS.all_paths_of_len rhs_re length in
              List.length w1 + List.length w2 > 2
              || (List.length w1 = 1
                  && List.length w2 = 1
                  && List.nth w1 0 <> List.nth w2 0))
            else lhs_re |> NfaS.run && rhs_re |> NfaS.run
          in
          let constr = gensym ~prefix:"%under_distinct_3" () in
          let post
                (model : Ir.model)
                (orig_ast : Ast.t)
                (check_sat : Ast.t -> [ `Sat | `Unknown ])
            =
            if length_check (max (get_len lhs) (get_len rhs))
            then `Sat
            else begin
              let model_ast =
                Map.fold
                  ~f:(fun ~key ~data acc ->
                    let key =
                      match key with
                      | Ir.Var key -> key
                      | _ -> assert false
                    in
                    match data with
                    | `Int d ->
                      (*Ast.Eia.eq
                        (Ast.Eia.atom (Ast.var key Ast.I))
                        (Ast.Eia.const d)
                        Ast.I
                      :: *)
                      acc
                    | `Str s ->
                      Ast.Eia.eq
                        (strleni key)
                        (Ast.Eia.const (String.length s |> Z.of_int))
                        Ast.I
                      :: acc)
                  ~init:[]
                  model
                |> List.map Ast.eia
                |> Ast.land_
              in
              let ast =
                Ast.land_
                  [ Ast.eia (Ast.Eia.eq (strleni lhs) (strleni rhs) Ast.I)
                  ; Ast.eia (Ast.Eia.eq (atomi lhs) (atomi rhs) Ast.I)
                  ; Ast.eia
                      (Ast.Eia.eq (atomi lhs) (Id_symantics.constz Z.minus_one) Ast.I)
                  ; Ast.eia (Ast.Eia.leq (Ast.Eia.const Z.one) (strleni lhs))
                  ; Ast.lnot model_ast
                  ; orig_ast
                  ]
                |> Ast.to_dnf
              in
              if List.exists (fun ast -> check_sat ast = `Sat) ast then `Sat else `Unknown
            end
          in
          posts := Map.add_exn !posts ~key:constr ~data:post;
          Ast.land_
            [ Ast.eia (Ast.Eia.eq (strleni lhs) (strleni rhs) Ast.I)
            ; Ast.eia (Ast.Eia.eq (atomi lhs) (atomi rhs) Ast.I)
            ; Ast.eia (Ast.Eia.eq (atomi lhs) (Id_symantics.constz Z.minus_one) Ast.I)
            ; Ast.eia (Ast.Eia.leq (Ast.Eia.const Z.one) (strleni lhs))
            ; Ast.Unsupp constr
            ]
        in
        Ast.lor_ [ ast1; ast2; ast3 ])
    in
    asts
    |> (fun asts -> Ast.to_dnf asts)
    |> List.map (fun ast ->
      let posts' = ref [] in
      let ast =
        Ast.map
          (function
            | Unsupp s when Map.mem !posts s ->
              posts' := Map.find_exn !posts s :: !posts';
              Ast.true_
            | ast -> ast)
          ast
      in
      ast, !posts')
  in
  let var_info = apply_symantics (module Who_in_exponents) ast in
  let alpha = collect_alpha ast in
  let (module Symantics) = make_main_symantics ~alpha:(Utils.with_extra_char alpha) env in
  let with_empty_cases ast =
    let open Ast in
    let open Ast.Eia in
    let important_vars = get_stoi_conc_vars ast in
    Utils.powerset important_vars
    |> List.map (fun empty_vars ->
      List.map (fun var -> eia (Eq (Atom (Var (var, S)), str_const "", S))) empty_vars)
    |> List.map (fun ast' -> land_ (ast :: ast'))
  in
  let str_vars_options ast env =
    let open Ast in
    let open Ast.Eia in
    match Ast.get_stoi_conc_vars ast with
    | [] -> [ [], fold_regexes ast, env ]
    | important_vars ->
      Utils.powerset important_vars
      |> List.map (fun str_vars ->
        let ph =
          List.map
            (fun var ->
               if List.mem var str_vars
               then eia (Leq (Const Z.one, Len (Atom (Var (var, S)))))
               else eia (Leq (Const Z.zero, Iofs (Atom (Var (var, S))))))
            important_vars
        in
        let ast = land_ (ast :: ph) in
        str_vars, fold_regexes ~str_vars ast, env)
  in
  ast
  |> with_empty_cases
  |> List.concat_map Ast.to_dnf
  |> List.map (apply_symantics (module Symantics))
  (*|> List.map (fun ((ast) as v) ->
    Format.printf "> %a\n%!" Ast.pp_smtlib2 ast;
    Format.printf "   %a\n%!" (Env.pp ~title:"") env;
    v)*)
  |> List.filter_map (fun ast ->
    match basic_simplify [ 0 ] env ast with
    | `Unsat -> None
    | `Sat env -> Some (Ast.true_, env)
    | `Unknown (ast, env, _, _) -> Some (ast, env))
  |> List.concat_map (fun (ast, env) ->
    List.map (fun ast -> ast, env) (ast |> Ast.to_dnf))
  (*|> List.map (fun (((ast, regexes)) as v) ->
    Format.printf "> %a\n%!" Ast.pp_smtlib2 ast;
    Format.printf "   %a\n%!" (Env.pp ~title:"") env;
    v)*)
  |> List.concat_map (fun (ast, env) -> str_vars_options ast env)
  (*|> List.map (fun ((str_vars, (ast, regexes), env) as v) ->
    Format.printf ">> %a\n%!" Ast.pp_smtlib2 ast;
    Format.printf "   %a\n%!" (Env.pp ~title:"") env;
    Format.printf "   %a\n%!" (Format.pp_print_list Format.pp_print_string) str_vars;
    v)*)
  |> List.concat_map (fun (str_vars, (ast, regexes), env) ->
    List.map
      (fun ast' ->
         let ast', regexes' = fold_regexes_i ast' in
         let regexes =
           Map.merge
             ~f:(fun ~key -> function
                | `Left v -> Some v
                | `Right v -> Some v
                | `Both (v, v') -> Some (NfaS.intersect v v'))
             regexes
             regexes'
         in
         ast', regexes, env)
      (ast |> flatten |> arithmetize var_info str_vars))
  |> List.concat_map (fun (a, b, env) ->
    unfold_neq var_info b a |> List.map (fun (a, a') -> a, env, a', b))
;;

let leq_simpl l r =
  let (module TS : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  let ans = TS.prj TS.(l <= r) in
  Format.printf "@[%a@]\n%!" Ast.pp_smtlib2 ans
;;

let%expect_test " -2x <= -7" =
  let (module TS : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  leq_simpl TS.(mul [ const (-2); var "x" ]) TS.(const (-7));
  [%expect "(<= (* (- 2) x) (- 7))"]
;;

let%expect_test " -2x <= -8" =
  let (module TS : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  leq_simpl TS.(mul [ const (-2); var "x" ]) TS.(const (-8));
  [%expect "(<= (* (- 2) x) (- 8))"]
;;

let%expect_test " -2x <= -1" =
  let (module TS : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  leq_simpl TS.(mul [ const (-2); var "x" ]) TS.(const (-1));
  [%expect "(<= (* (- 2) x) (- 1))"]
;;
