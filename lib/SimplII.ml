[@@@warning "+unused-value-declaration"]

let log = Utils.log

module NfaS = Nfa.Lsb (Nfa.Str)

(* module Term_map = Map.Make (struct
    type t =
      [ `Eia of Ast.Eia.term
      | `Str of Ast.Str.term
      ]

    let compare = Stdlib.compare
  end) *)

type error =
  | Non_linear_arith : Z.t Ast.Eia.term list -> error
  | Non_linear_string : string Ast.Eia.term list -> error

let compare_error : error -> _ = Stdlib.compare

let pp_error ppf = function
  | Non_linear_arith ts ->
    Format.fprintf ppf "@[<v 2>";
    Format.fprintf ppf "@[Non linear arithmetic between@]@,";
    List.iteri
      (fun i term -> Format.fprintf ppf "@[%d) %a@]@," i Ast.pp_term_smtlib2 term)
      ts;
    Format.fprintf ppf "@]"
  | Non_linear_string ts ->
    Format.fprintf ppf "@[<v 2>";
    Format.fprintf ppf "@[Non linear string logic between@]@,";
    List.iteri
      (fun i term -> Format.fprintf ppf "@[%d) %a@]@," i Ast.pp_term_smtlib2 term)
      ts;
    Format.fprintf ppf "@]"
;;

let check_errors ph =
  let open Ast.Eia in
  let not_a_const (type a) : a term -> bool = function
    | Str_const _ | Const _ -> false
    | _ -> true
  in
  let on_int_term acc = function
    | Mul xs ->
      let xs = List.filter not_a_const xs in
      (match xs with
       | [ Str_const _ ] | [ Const _ ] -> assert false
       | [ Pow (Const _, _) ] | [ Atom (Var _) ] | [] -> acc
       | xs -> Non_linear_arith xs :: acc)
    | Pow (base, Const _) as ans when not_a_const base -> Non_linear_arith [ ans ] :: acc
    | _ -> acc
  in
  let on_str_term acc = function
    | Concat (Str_const lhs, rhs) | Concat (rhs, Str_const lhs) -> acc
    | Concat (lhs, rhs) as ans -> Non_linear_string [ ans ] :: acc
    | _ -> acc
  in
  Ast.fold
    (fun errs -> function
       | Ast.Eia eia -> Ast.Eia.fold2 on_int_term on_str_term errs eia
       | _ -> errs)
    []
    ph
  |> Base.List.dedup_and_sort ~compare:compare_error
;;

let has_unsupported_nonlinearity =
  let open Ast.Eia in
  let not_a_const (type a) : a term -> bool = function
    | Const _ -> false
    | _ -> true
  in
  let on_term acc = function
    | Mul xs ->
      let xs = List.filter not_a_const xs in
      (match xs with
       | [ Const _ ] -> assert false
       | [ Pow (Const _, _) ] | [ Atom (Var _) ] | [] -> acc
       | xs ->
         let rec loop acc = function
           | [ _ ] | [] -> acc
           | Atom (Var (x, I)) :: r -> Atom (Var (x, I)) :: acc
           (* | Atom (Var _) :: Atom (Var _) :: _ -> (*Ast.Eia.mul [ l; r ] ::*) acc *)
           | h :: tl -> loop acc tl
         in
         loop acc xs)
    | Pow (base, Const _) as t when not_a_const base -> t :: acc
    | _ -> acc
  in
  fun ph ->
    let f acc = function
      | Ast.Eia eia -> Ast.Eia.fold2 on_term (fun acc _ -> acc) acc eia
      | _ -> acc
    in
    match Ast.fold f [] ph with
    | [] -> Result.Ok ()
    | xs -> Result.Error (Base.List.dedup_and_sort ~compare:Ast.Eia.compare_term xs)
;;

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

  (** TODO(Kakadu): I forgot what it is *)
  val str_from_eia_const : Z.t -> str

  (*
     val str_concat : str -> str -> str
  val str_equal : str -> str -> ph
  val pow2var : string -> term
  *)
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

let compare_ast l r =
  match l, r with
  | Ast.True, Ast.True -> 0
  | True, _ -> -1
  | _, True -> 1
  | Lnot _, _ -> -1
  | _, Lnot _ -> 1
  | _ -> Ast.compare l r
;;

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
  let land_ xs = Ast.Land xs
  let lor_ xs = Ast.Lor xs
  let not = Ast.lnot
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
  let eq_str l r = Ast.Eia (Ast.Eia.eq l r Ast.S)
  let leq l r = Ast.Eia (Ast.Eia.leq l r)
  let lt l r = Ast.Eia (Ast.Eia.lt l r)
  let true_ = Ast.true_
  let false_ = Ast.false_
  let prj = Fun.id
  let pow_minus_one t = pow (const (-1)) t

  let pow2var c =
    Ast.Eia.pow (Ast.Eia.const (Config.base ())) (Ast.Eia.atom (Ast.var c I))
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
    | Pow (Const base, Atom (Ast.Var (x, I))) when base = Config.base () ->
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

(*let apply_symantics (type a) (module S : SYM_SUGAR with type ph = a) =
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
  and helper_str : Ast.Str.term -> S.str = function
    | Ast.Str.Const s -> S.str_const s
    | Ast.Str.Atom (Ast.Var s) -> S.str_var s
    | Atom (Const _) -> failwith "should not happen"
    | FromEia (Var eia) -> S.str_from_eia eia
    | FromEia (Const c) -> S.str_from_eia_const c
    | Concat (s1, s2) -> S.str_concat (helper_str s1) (helper_str s2)
    | Substr (s1, Var a, Var b) -> S.str_substr (helper_str s1) a b
    | Substr (s1, _, _) -> failwith "unimplemented"
    | At (s1, Var a) -> S.str_at (helper_str s1) a
    | At (s1, _) -> failwith "unimplemented"
  and helperT = function
    | Ast.Eia.Atom (Ast.Const n) -> S.const (Z.to_int n)
    | Atom (Ast.Var s) -> S.var s
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    | Pow (Atom (Ast.Const base), Atom (Ast.Var x)) when base = Config.base () ->
      S.pow2var x
    | Pow (base, Atom (Ast.Const p)) when p = Z.zero -> S.const 1
    | Pow (base, Atom (Ast.Const p)) when p = Z.one -> helperT base
    | Pow (base, Atom (Ast.Const p)) when p < Z.of_int 10 ->
      S.mul [ helperT base; helperT (Pow (base, Atom (Ast.Const Z.(p - Z.one)))) ]
    | Pow (base, p) -> S.pow (helperT base) (helperT p)
    | Bwand (l, r) -> S.bw FT_SIG.Bwand (helperT l) (helperT r)
    | Bwor (l, r) -> S.bw FT_SIG.Bwor (helperT l) (helperT r)
    | Bwxor (l, r) -> S.bw FT_SIG.Bwxor (helperT l) (helperT r)
    | Mod (t, z) -> S.mod_ (helperT t) z
    | Len (Ast.Str.Atom (Var s)) ->
      let l = S.str_var s in
      (* Format.printf "%s %d: l = %a\n%!" __FUNCTION__ __LINE__ S.pp_str l; *)
      S.str_len l
    | Len (Ast.Str.Const s) -> S.const (String.length s)
    | Stoi (Ast.Str.Atom (Var s)) -> S.str_atoi (S.str_var s)
    | Stoi (Ast.Str.Const s) ->
      (match int_of_string_opt s with
       | Some n -> S.const n
       | None -> S.str_atoi (S.str_const s))
    | Stoi2 (Var s) -> S.stoi2 s
    | Stoi2 (Const _) -> failwith "TBD"
    | Len2 (Var s) -> S.str_len2 s
    | Len2 (Const _) -> failwith "TBD"
    | (Stoi (Ast.Str.Atom (Const _)) | Len (Ast.Str.Atom (Const _))) as t ->
      Format.eprintf "%a\n%!" Ast.Eia.pp_term t;
      failwith "Strlen/Stoi should not be called from int constants. Types are bad"
    | eia -> failwith (Format.asprintf "Not yet implement: %a" Ast.pp_term_smtlib2 eia)
      S.str_equal l r
  and helper_eia eia =
    match eia with
    | Ast.Eia.Eq (l, r, I) -> S.(helperT l = helperT r)
    | Eq (l, r, S) -> S.eq_str (helperS l) (helperS r)
    | Leq (l, r) -> S.(helperT l <= helperT r)
    | PrefixOf (term, term') -> S.str_prefixof (helperS term) (helperS term')
    | Contains (term, term') -> S.str_contains (helperS term) (helperS term')
    | SuffixOf (term, term') -> S.str_suffixof (helperS term) (helperS term')
    | InRe (term, Ast.S, regex) -> S.in_re (helperS term) regex
    | InRe (term, Ast.I, regex) -> S.in_rei (helperT term) regex
    | InReRaw (term, regex) -> S.in_re_raw (helperS term) regex
  in
  helper
;;*)

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
  let eqz = ( ++ )
  let eq_str = ( ++ )
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

let make_main_symantics env =
  let _ : Env.t = env in
  let module Main_symantics_ = struct
    open Ast
    include Id_symantics

    let compare_term = Eia.compare_term
    let constz c = Ast.Eia.Const c
    let const c = constz (Z.of_int c)

    let var s : term =
      match Env.lookup_int s env with
      (*| Some (Eia.Iofs _)
      | Some (Eia.Sofi _)
      | Some (Eia.Len _)
      | Some (Eia.Len2 _)*)
      | None -> begin
        match Env.lookup_string s env with
        | Some (Str_const c) -> begin
          match Id_symantics.constz (Z.of_string c) with
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
      | None -> begin
        match Env.lookup_int s env with
        | Some c -> Ast.Eia.sofi c
        | None -> Eia.Atom (Ast.Var (s, S))
      end
    ;;

    let str_len = function
      | Ast.Eia.Str_const s -> Id_symantics.const (String.length s)
      | s -> Id_symantics.str_len s
    ;;

    let str_concat lhs rhs =
      match lhs, rhs with
      | Ast.Eia.Str_const lhs, Ast.Eia.Str_const rhs ->
        Id_symantics.str_const (String.concat "" [ lhs; rhs ])
      | lhs, rhs -> Id_symantics.str_concat lhs rhs
    ;;

    let str_len2 = function
      | Ast.Eia.Str_const s ->
        Id_symantics.constz Z.(pow (Config.base ()) (String.length s) - one)
      | s -> Id_symantics.str_len2 s
    ;;

    let iofs = function
      | Ast.Eia.Str_const s -> Id_symantics.constz (Z.of_string s)
      | s -> Id_symantics.iofs s
    ;;

    let sofi = function
      | Ast.Eia.Const s -> Id_symantics.str_const (Z.to_string s)
      | s -> Id_symantics.sofi s
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

    let str_prefixof s1 s2 = Ast.eia (Ast.Eia.prefixof s1 s2)
    let str_contains s1 s2 = Ast.eia (Ast.Eia.contains s1 s2)
    let str_suffixof s1 s2 = Ast.eia (Ast.Eia.suffixof s1 s2)

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
        when Z.(equal c (Config.base ())) && base_ = Config.base () && v1 = Z.minus_one ->
        pow base v
      | c, [ Add ss ] -> Eia.Add (List.map (fun x -> Eia.Mul [ constz c; x ]) ss)
      | c, xs -> Ast.Eia.mul (constz c :: List.sort compare_term xs)

    and pow base xs =
      match base, xs with
      | _, Eia.Const c when c = Z.zero -> const 1
      | Eia.Pow (base, e1), e2 -> Eia.Pow (base, Eia.Mul [ e1; e2 ])
      | Mul ((Const c as base0) :: tl), Eia.Const e ->
        mul [ pow base0 xs; pow (Mul tl) xs ]
      | Eia.Const b, Eia.Const exp when Z.(exp > zero) ->
        (try const (Z.to_int (Utils.powz ~base:b exp)) with
         | Z.Overflow -> Ast.Eia.Pow (base, xs))
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
      | Ast.Lnot x -> x
      | Land xs -> Ast.Lor (List.map not xs)
      | Lor xs -> Ast.Land (List.map not xs)
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
      let flat = Base.List.dedup_and_sort ~compare:compare_ast flat in
      match flat with
      | [] -> false_
      | Lnot True :: _ -> false_
      | [ h ] -> h
      | _ ->
        (match List.drop_while (( = ) Ast.True) flat with
         | [] -> true_
         | xs -> Ast.Land xs)
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
      | Eia.Add ls, Eia.Add rs -> ofop (add (ls @ List.map negate rs)) (const 0)
      | Eia.Add (Const c :: tl), Const n -> ofop (add tl) (const Z.(to_int (n - c)))
      | Const c, Add (Const n :: tl) ->
        ofop (add (List.map negate tl)) (const Z.(to_int (n - c)))
      | Const c, Add xs -> ofop (add (List.map negate xs)) (const Z.(to_int (-c)))
      | Pow (basel, powl), Pow (baser, powr) when basel = baser -> ofop powl powr
      | Eia.Mul [ Const c; (Atom (Var (_, _)) as v) ], Eia.(Const rhs)
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
          ofop l r
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
      | _ -> Id_symantics.eq_str l r
    ;;

    let eqz x y =
      (* TODO(Kakadu): rewrite to match twice for readability *)
      let ans = relop Eq x y in
      match ans with
      | Eia (Eia.Eq (Add xs, Add ys, _)) -> assert false
      | Eia (Eia.Eq (Mul (Const l :: ltl), Mul (Const r :: rtl), I)) ->
        let gcd1 = Z.gcd l r in
        if Z.(equal gcd1 one)
        then ans
        else
          Eia
            (Eia.Eq (mul (constz Z.(l / gcd1) :: ltl), mul (constz Z.(r / gcd1) :: rtl), I))
      | Eia (Eia.Eq (l, r, I)) when Eia.eq_term l r -> true_
      | Eia (Eia.Eq (Eia.Sofi (Const v1), Str_const r, I))
      | Eia (Eia.Eq (Str_const r, Eia.Sofi (Const v1), I)) ->
        let l = Z.to_string v1 in
        if
          String.length l <= String.length r
          && String.ends_with ~suffix:l r
          && String.for_all
               (Char.equal '0')
               (String.sub r (String.length l) (String.length r - String.length l))
        then Ast.true_
        else Ast.false_
      | _ -> ans
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
      | Ast.Eia.Atom (Ast.Var (s, S)) -> begin
        match Env.lookup_string s env with
        | Some (Ast.Eia.Str_const _ as c) -> Ast.eia (Eia.inre c Ast.S re)
        | Some (Ast.Eia.Const c) -> begin
          match
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
        begin
          match
            NfaStr.of_regex re
            |> NfaStr.intersect (from_eia_nfa c)
            |> NfaStr.run (*(String.to_seq str |> List.of_seq |> List.rev)*)
          with
          | true -> Ast.true_
          | false -> Ast.false_
        end
      | Ast.Eia.(Str_const str) -> begin
        match
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
      | Ast.Eia.(Const c) -> begin
        match NfaStr.of_regex re |> NfaStr.intersect (from_eia_nfa c) |> NfaStr.run with
        | true -> Ast.true_
        | false -> Ast.false_
      end
      | _ -> Id_symantics.in_rei s re
    ;;

    let in_re_raw s re =
      let module NfaStr = Nfa.Lsb (Nfa.Str) in
      match s with
      | Ast.Eia.(Str_const str) -> begin
        match re |> NfaStr.re_accepts (String.to_seq str |> List.of_seq |> List.rev) with
        | true -> Ast.true_
        | false -> Ast.false_
      end
      | _ -> Id_symantics.in_re_raw s re
    ;;

    let in_re_rawi s re =
      let module NfaStr = Nfa.Lsb (Nfa.Str) in
      match s with
      | Ast.Eia.(Const c) -> begin
        match re |> NfaStr.intersect (from_eia_nfa c) |> NfaStr.run with
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

(* let apply_term_symantics
  : (module SYM with type term = Ast.Eia.term) -> Ast.Eia.term -> Ast.Eia.term
  =
  fun (module S : SYM with type term = Ast.Eia.term) ->
  let rec helperT = function
    | Ast.Eia.Atom (Ast.Const n) as c -> c
    | Atom (Ast.Var s) -> S.var s
    | Atom (Ast.Str_const c) -> S.str_const c
    | Add terms -> S.add (List.map helperT terms)
    | Mul terms -> S.mul (List.map helperT terms)
    | Pow (base, p) -> S.pow (helperT base) (helperT p)
    | Bwand (l, r) -> S.bw Bwand (helperT l) (helperT r)
    | Bwor (l, r) -> S.bw Bwor (helperT l) (helperT r)
    | Bwxor (l, r) -> S.bw Bwxor (helperT l) (helperT r)
    | Mod (t, z) -> S.mod_ (helperT t) z
    | Len (Ast.Eia.Atom (Str_const s)) -> S.const (String.length s)
    | Len s -> S.str_len (helperT s)
    | Iofs (Ast.Eia.Atom (Str_const s)) ->
      (match int_of_string_opt s with
       | Some n -> S.const n
       | None -> S.iofs (S.str_const s))
    | Iofs s -> S.iofs (helperT s)
    | Sofi s -> S.sofi (helperT s)
    | Len2 (Var s) -> S.str_len2 s
    | Len2 (Const _) -> failwith "TBD"
    | Len2 (Str_const _) -> failwith "TBD"
    (* | Ast.Eia.Atom (Var s) -> S.str_var s *)
    (* |   (Const s) as ast ->
      Format.eprintf "%a\n%!" Ast.Str.pp_term ast;
      failwith "tbd"
    | Atom (Str_const c) -> S.str_const c *)
    | Ast.Eia.Concat (lhs, rhs) -> S.str_concat (helperT lhs) (helperT rhs)
    (* | Ast.Eia.FromEia (Var s) -> S.str_from_eia s *)
    (* | Ast.Eia.FromEia (Const c) -> S.str_from_eia_const c *)
    | Substr (lhs, Var s1, Var s2) -> S.str_substr (helperT lhs) s1 s2
    | Substr (lhs, _, _) as ast ->
      Format.eprintf "%a\n%!" Ast.Eia.pp_term ast;
      failwith "tbd"
    | At (lhs, Var s1) -> S.str_at (helperT lhs) s1
    | At (lhs, _) as ast ->
      Format.eprintf "%a\n%!" Ast.Eia.pp_term ast;
      failwith "tbd"
  in
  helperT
;; *)

let subst_term (type a) env (term : a Ast.Eia.term) =
  let (module S : SYM_SUGAR_AST) = make_main_symantics env in
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
          (<= x 2)
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
      log "%s: %a -> %a" __FUNCTION__ Ast.pp_term_smtlib2 key Ast.pp_term_smtlib2 t;
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

let find_vars_for_under2 ast =
  let module S = Base.Set.Poly in
  let fz : string S.t -> Z.t Ast.Eia.term -> _ =
    fun acc ->
    fun c ->
    match c with
    (*function*)
    | Ast.Eia.Mul [ Atom (Var (v, _)); Pow (Const base, _) ]
    | Ast.Eia.Mul [ Pow (Const base, _); Atom (Var (v, _)) ]
      when Z.(equal (Config.base ()) base) -> S.add acc v
    | Mul [ Const _; Atom (Var (v, I)); Pow (Const base, _) ]
      when Z.(equal (Config.base ()) base) -> S.add acc v
    | Mul [ Atom (Var (v, _)); Pow (Const base, _) ] when Z.(equal (Config.base ()) base)
      -> S.add acc v
    | Mul [ Atom (Var (v1, _)); Atom (Var (v2, _)) ] -> S.add (S.add acc v1) v2
    | t ->
      (* Format.printf "skipping: @[%a@]\n%!" Ast.Eia.pp_term t; *)
      acc
  in
  let fs = fun acc _ -> acc in
  Ast.fold
    (fun acc ->
       let open Ast.Eia in
       function
       | Eia (Eq (l, r, I)) -> fold_term fz fs (fold_term fz fs acc r) l
       | Eia (Leq (l, r)) -> fold_term fz fs (fold_term fz fs acc r) l
       | _ -> acc)
    S.empty
    ast
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ph =
    let set = find_vars_for_under2 ph in
    Format.printf
      "@[%a@]\n%!"
      Format.(pp_print_list ~pp_sep:(fun ppf () -> fprintf ppf " ") pp_print_string)
      (Base.Set.to_list set)
  in
  test
    TS.(
      add [ pow (constz (Config.base ())) (var "x"); mul [ const 2; var "y" ] ] = var "z");
  [%expect ""];
  test TS.(mul [ pow (constz (Config.base ())) (var "x"); var "y" ] = var "z");
  [%expect "y"];
  test TS.(mul [ var "y"; pow (constz (Config.base ())) (var "x") ] = var "z");
  [%expect "y"];
  ()
;;

let shrink_variables ast =
  let module Set = Base.Set.Poly in
  let _ : Ast.t = ast in
  (* log "old ast: @[%a@]\n" Ast.pp_smtlib2 ast; *)
  let info = apply_symantics (module Who_in_exponents) ast in
  (* log "@[<v 2>@[Old info:@]@ @[%a@]@]\n" Info.pp_hum info; *)
  (* let is_in_expo v = Info.is_in_expo v info in *)
  let lin, exp = Ast.collect_lin_exp ast in
  let is_in_expo v = Info.is_in_expo v info && Set.mem lin v in
  let same_base l r = is_in_expo l && is_in_expo r in
  (* Now let's make exponential variables more exponential *)
  let module Sy = struct
    open Ast
    include Id_symantics
    include FT_SIG.Sugar (Id_symantics)

    (* TODO(Kakadu): maybe a syntax extension for better matching? *)
    (* TODO: detect base from variable usage  *)
    let good_enough_constant rhs = Z.lt rhs (Z.of_int (Config.huge_const ()))

    let leq l r =
      let base = constz (Config.base ()) in
      let open Eia in
      (* Format.printf "TRACE: @[%a@]\n%!" Ast.pp_smtlib2 (Id_symantics.leq l r); *)
        match l, r with
        | Atom (Var (v, _)), Const rhs when is_in_expo v && good_enough_constant rhs ->
          (* v<=c ~~> 10^v <= 10^c *)
          Id_symantics.(leq (base ** l) (base ** r))
        | Const lhs, Atom (Var (v, _)) when is_in_expo v && good_enough_constant lhs ->
          (* c<=v ~~> 10^c <= 10^v *)
          Id_symantics.(leq (base ** l) (base ** r))
        | Add [ Atom (Var (v, _)); Mul [ Const m1; Atom (Var (v2, _)) ] ], Eia.(Const z)
          when same_base v v2
               && Z.(equal z zero)
               && Z.(equal m1 minus_one)
               && good_enough_constant z
               (* v - v2 <=0 ~~>  10^v <= 10^v2  *) ->
          Id_symantics.(leq (base ** var v) (base ** var v2))
        | Add [ Atom (Var (v, _)); Mul [ Const c; Atom (Var (v2, _)) ] ], Eia.(Const z)
          when same_base v v2
               && Z.(equal z zero)
               && Z.(lt c zero)
               && good_enough_constant z
               (* v - c*v2 <= 0 ~~>  10^v2 <= (10^c)^v) *) ->
          Id_symantics.(leq (base ** var v2) (pow (base ** constz (Z.abs c)) (var v)))
        | _ -> Id_symantics.leq l r
    ;;
  end
  in
  let ast2 = apply_symantics_unsugared (module Sy) ast in
  if Set.length (ast2 |> Ast.collect_lin_exp |> fst) < Set.length lin
  then (
    log "Post-simplification: @[%a@]\n" Ast.pp_smtlib2 ast2;
    let info2 = apply_symantics (module Who_in_exponents) ast in
    log "@[<v 2>@[New info:@]@ @[%a@]@]\n" Info.pp_hum info2;
    ast2)
  else ast
;;

let%test_module "about shrinking" =
  (module struct
    let wrap f =
      let ast = Ast.land_ (f (make_main_symantics Env.empty)) in
      (* let ast =
        match simpl 0 ast with
        | `Unknown ast -> ast
        | `Sat _ -> failwith (Printf.sprintf "Too simple test %d" __LINE__)
        | `Error _ -> failwith (Printf.sprintf "Too simple test %d" __LINE__)
        | `Underapprox _ -> failwith (Printf.sprintf "Too simple test %d" __LINE__)
        | `Unsat -> failwith (Printf.sprintf "Too simple test %d" __LINE__)
      in *)
      Format.printf "%a\n%!" Ast.pp_smtlib2 ast;
      let ast = shrink_variables ast in
      Format.printf "           @ @[%a@]%!" Ast.pp_smtlib2 ast
    ;;

    let%expect_test "The simplest thing" =
      wrap (fun (module TS : SYM_SUGAR_AST) ->
        let open TS in
        [ add [ pow2var "x"; pow2var "y" ] <= const 52; var "x" <= const 3 ]);
      [%expect
        {|
        (and
          (<= (+ (exp 2 x) (exp 2 y)) 52)
          (<= x 3))

        (and
          (<= (+ (exp 2 x) (exp 2 y)) 52)
          (<= (exp 2 x) (exp 2 3)))
        |}]
    ;;

    let%expect_test "Without interesting coefs" =
      (* TODO: different bases are not yet supported *)
      wrap (fun (module TS : SYM_SUGAR_AST) ->
        let open TS in
        [ add [ pow2var "x"; pow2var "y"; const 10 ** var "u"; const 10 ** var "v" ]
          <= const 5000
        ; add [ var "x"; mul [ const (-1); var "y" ] ] <= const 0
        ; add [ mul [ const (-1); var "u" ]; var "v" ] <= const 0
        ]);
      [%expect
        {|
        (and
          (<= (+ (exp 2 x) (exp 2 y) (exp 10 u) (exp 10 v)) 5000)
          (<= (+ x (* (- 1) y)) 0)
          (<= (+ v (* (- 1) u)) 0))

        (and
          (<= (+ (exp 2 x) (exp 2 y) (exp 10 u) (exp 10 v)) 5000)
          (<= (+ x (* (- 1) y)) 0)
          (<= (+ v (* (- 1) u)) 0))
        |}]
    ;;

    let%expect_test "With coeffs" =
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

        (and
          (<= (+ (exp 2 x) (exp 2 y)) 52)
          (<= (+ x (* (- 3) y)) 0))
        |}]
    ;;
  end)
;;

let gensym =
  let n = ref 0 in
  fun ?(prefix = "eee") () ->
    incr n;
    Printf.sprintf "%s%d" prefix !n
;;

let flatten { Info.all; _ } =
  let gensym1 = gensym in
  let rec gensym () =
    let ans = gensym1 ~prefix:"%flat_pow" () in
    if Base.Set.Poly.mem all ans then gensym () else ans
  in
  let extra_ph = ref [] in
  let mapping = ref ZTM.empty in
  let extend v other =
    extra_ph := Id_symantics.eqz (Id_symantics.var v) other :: !extra_ph;
    mapping := ZTM.add other v !mapping
  in
  let module M_ = struct
    include Id_symantics

    let pow base e =
      match e with
      | Ast.Eia.Atom (Ast.Var _) | Ast.Eia.(Const _) -> Id_symantics.pow base e
      | _ ->
        (match ZTM.find e !mapping with
         | exception Not_found ->
           let newv = gensym () in
           extend newv e;
           Id_symantics.pow base (Id_symantics.var newv)
         | newv -> Id_symantics.pow base (Id_symantics.var newv))
    ;;

    let prj = function
      | Ast.Land xs -> land_ (!extra_ph @ xs)
      | ph -> land_ (!extra_ph @ [ ph ])
    ;;
  end
  in
  let module Sym = struct
    include M_
    include FT_SIG.Sugar (M_)
  end
  in
  fun ph -> Sym.prj (apply_symantics (module Sym) ph)
;;

let make_smtml_symantics (env : (string, _) Base.Map.Poly.t) =
  let module M = struct
    include FT_SIG.To_smtml_symantics

    type repr = term

    let prj = Fun.id

    let var s =
      match Base.Map.Poly.find env s with
      | None -> Smtml.Expr.symbol (Smtml.Symbol.make Smtml.Ty.Ty_int s)
      | Some c -> constz c
    ;;

    let str_from_eia_const _ = failwith "not implemented"
    let str_concat _ = failwith "not implemented"
    let str_at _ = failwith "not implemented"
    let str_substr _ = failwith "not implemented"
    let str_prefixof _ = failwith "not implemented"
    let str_contains _ = failwith "not implemented"
    let str_suffixof _ = failwith "not implemented"

    (*let pow2var s = pow (const Z.(Config.base () |> to_int)) (var s)*)
    let pow_minus_one t = pow (constz Z.minus_one) t
    let exists vars x = failwith "tbd"
    let pow2var s = pow (constz (Config.base ())) (var s)
    let str_len2 _ = failwith "not implemented"
    let pp_str = Smtml.Expr.pp
    let const c = constz (Z.of_int c)
    let in_rei _ = failwith "not implemented"
    let in_re_raw _ = failwith "not implemented"
    let in_re_rawi _ = failwith "not implemented"
    let rlen _ = failwith "not implemented"
    let unsupp _ = failwith "not implemented"
  end
  in
  (module struct
    include M
    include FT_SIG.Sugar (M)
  end : SYM_SUGAR
    with type ph = Smtml.Expr.t)
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
      | Eia eia -> begin
        match eia with
        | Eia.RLen (Eia.Atom (Var (s, _)), _) when s = v -> true
        | _ -> in_strlen_eia v eia
      end
      | Lnot ast' | Exists (_, ast') -> in_strlen v ast'
      | Land asts | Lor asts ->
        List.fold_left (fun acc ast -> acc || in_strlen v ast) false asts
      | Unsupp _ -> failwith "unable to fold; unsupported constraint"
    in
    let var_can_subst v = Env.is_absent_key v env in
    let var_can_subst_complex v = var_can_subst v && not (in_strlen v orig_ast) in
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
      when var_can_subst vn -> Some (extend_exn env v rhs)
    | Eia (Eia.Eq (Atom (Var (vn, _) as v), (Eia.Iofs (Atom (Var _)) as rhs), _))
      when var_can_subst vn -> Some (extend_exn env v rhs)
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
          if not (Env.occurs_var env vn data)
          then extend_exn env v data
          else loop (Eia.Atom v :: acc) xs
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
      when var_can_subst_complex vn
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
      let ans_ph = if ys = [] && xs <> [] then True else Land ys in
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

exception Underapprox_fired of Env.t
exception Error of Ast.t * error list [@@ocaml.warnerror "-38"]

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

(* let lower_exp ast =
  let acc = ref [] in
  let extend ph = acc := ph :: !acc in
  let module M = struct
    include Id_symantics

    let pow t e =
      let exp = var (gensym ~prefix:"%exp" ()) in
      extend (eqz exp e);
      pow t exp
    ;;
  end
  in
  let ph = apply_symantics_unsugared (module M) ast in
  match !acc with
  | [] -> ph
  | acc -> Ast.land_ (ph :: acc)
;; *)

(* let lower_concats ast =
  let acc = ref [] in
  let extend ph = acc := ph :: !acc in
  let module M = struct
    include Id_symantics

    let str_concat lhs rhs =
      let c = str_var (gensym ~prefix:"%conc" ()) in
      extend (Id_symantics.eq_str c (Id_symantics.str_concat lhs rhs));
      c
    ;;
  end
  in
  let ph = apply_symantics_unsugared (module M) ast in
  match !acc with
  | [] -> ph
  | acc -> Ast.land_ (ph :: acc)
;; *)

(* let _lower_strlen ast =
  let env = ref Env.empty in
  let names : (string Ast.Eia.term, string) Base.Map.Poly.t ref =
    ref Base.Map.Poly.empty
  in
  let inames : (Z.t Ast.Eia.term, string) Base.Map.Poly.t ref = ref Base.Map.Poly.empty in
  let forgotten = ref Env.empty in
  let module Collector = struct
    open Ast.Eia
    include Id_symantics

    (*
       with type ph = Ast.t
   and type repr = Ast.t
   and type term = Z.t Ast.Eia.term
   and type str = string Ast.Eia.term = struct
    *)
    let eqz l r =
      let () =
        match l, r with
        | Atom (Var (vn, I) as v), (Iofs l as rhs)
        | (Iofs l as rhs), Atom (Var (vn, I) as v)
        | Atom (Var (vn, _) as v), (Len l as rhs)
        | (Len l as rhs), Atom (Var (vn, _) as v) ->
          if Env.is_absent_key vn !env
          then env := Env.extend_exn !env v rhs
          else forgotten := Env.extend_exn !forgotten v rhs;
          inames := Base.Map.Poly.set !inames ~key:rhs ~data:vn
        | _ -> ()
      in
      Ast.eia (eq l r I)
    ;;

    let eq_str (l : string Ast.Eia.term) r =
      let () =
        match l, r with
        | Atom (Var (vn, S) as v), (Sofi l as rhs)
        | (Sofi l as rhs), Atom (Var (vn, S) as v) ->
          if Env.is_absent_key vn !env
          then env := Env.extend_exn !env v rhs
          else forgotten := Env.extend_exn !forgotten v rhs;
          names := Base.Map.Poly.set !names ~key:rhs ~data:vn
        | _ -> ()
      in
      Ast.eia (eq l r S)
    ;;
  end
  in
  let module Lowering = struct
    open Ast.Eia
    include Id_symantics

    let str_len = function
      | Atom (Var (v, _)) ->
        let lv = Ast.Eia.Atom (Var (v, S)) in
        (match Base.Map.Poly.find !inames (Len lv) with
         | None ->
           let newvar = Ir.internal_name () in
           let lent = Id_symantics.str_len lv in
           env := Env.extend_int_exn !env newvar lent;
           inames := Base.Map.Poly.set !inames ~key:lent ~data:newvar;
           var newvar
         | Some t -> Id_symantics.var t)
      | _ -> failwith (Printf.sprintf "Not implemented: %s %d" __FILE__ __LINE__)
    ;;

    let sofi = function
      | Atom (Var (v, _)) ->
        let lv = Ast.Eia.Atom (Var (v, I)) in
        (match Base.Map.Poly.find !names (Sofi lv) with
         | None ->
           let newvar = Ir.internal_name () in
           let lent = Id_symantics.sofi lv in
           env := Env.extend_string_exn !env newvar lent;
           names := Base.Map.Poly.set !names ~key:lent ~data:newvar;
           Ast.Eia.atom (Ast.var newvar S)
         | Some t -> Ast.Eia.atom (Ast.var t S))
      | _ -> failwith (Printf.sprintf "Not implemented: %s %d" __FILE__ __LINE__)
    ;;
  end
  in
  let _ : Ast.t = apply_symantics_unsugared (module Collector) ast in
  match apply_symantics_unsugared (module Lowering) ast with
  | Ast.Land xs ->
    let new_phs =
      Env.to_eqs !env @ Env.to_eqs !forgotten @ List.map Id_symantics.prj xs
    in
    if new_phs = [] && xs <> [] then Ast.True else Ast.Land new_phs
  | ph -> Ast.Land ((ph :: Env.to_eqs !env) @ Env.to_eqs !forgotten)
;; *)

(* let rewrite_len ast =
  let module Map = Base.Map.Poly in
  let acc = ref [] in
  let lens = ref Map.empty in
  let module Collector = struct
    include Id_symantics

    let str_len str =
      match Map.find !lens str with
      | None ->
        let v = Ir.internal_name () in
        let lhs = Ast.Eia.len2 str in
        let rhs =
          add
            [ pow (Ast.Eia.const (Config.base ())) (Ast.Eia.atom (Ast.var v I))
            ; Ast.Eia.const Z.minus_one
            ]
        in
        acc := Ast.eia (Ast.Eia.eq lhs rhs Ast.I) :: !acc;
        let v = Ast.Eia.atom (Ast.var v I) in
        lens := Map.add_exn ~key:str ~data:v !lens;
        v
      | Some x -> x
    ;;
  end
  in
  let ast : Ast.t = apply_symantics_unsugared (module Collector) ast in
  let ast = Ast.land_ (ast :: !acc) in
  log "rewritten lengths= @[%a@]" Ast.pp_smtlib2 ast;
  ast
;; *)

let basic_simplify step ?multiple (env : Env.t) ast =
  log "iter(%a)= @[%a@]" pp_step step Ast.pp_smtlib2 ast;
  let rec loop step (env : Env.t) ast =
    let (module Symantics) = make_main_symantics env in
    let rez = apply_symantics (module Symantics) ast in
    let ast2 = Symantics.prj rez in
    (* log "Ast after main_symantics: @[%a@]" Ast.pp_smtlib2 ast2; *)
    (* let ast2 = ast2 |> propagate_exponents |> shrink_variables in *)
    let ast2 = propagate_exponents ast2 in
    let __ _ = log "Ast after propagate_exponents: @[%a@]" Ast.pp_smtlib2 ast2 in
    let var_info = apply_symantics (module Who_in_exponents) ast in
    (* Format.printf "%s: info = @[%a@]\n%!" __FUNCTION__ Info.pp_hum var_info; *)
    let env2, ast2 = eq_propagation var_info ?multiple env ast2 in
    let __ _ = log "env2 = %a" (Env.pp ~title:"") env2 in
    let __ () = log "ast2 = @[%a@]" Ast.pp_smtlib2 ast2 in
    let next_step = next step in
    match Env.length env2 > Env.length env, Ast.safe_eq ast ast2 with
    | true, equal ->
      let () = log "%a" (Env.pp ~title:"Something ready to substitute") env2 in
      let __ () = log "ast2 = @[%a@]" Ast.pp_smtlib2 ast2 in
      if not equal then log "iter(%a)= @[%a@]" pp_step next_step Ast.pp_smtlib2 ast2;
      loop next_step (Env.merge_exn env2 env) ast2
    | false, false ->
      log "iter(%a)= @[%a@]" pp_step next_step Ast.pp_smtlib2 ast2;
      loop next_step env ast2
    | false, true ->
      log "fixed-point\n";
      (match ast2 with
       | Ast.True -> raise (Sat ("presimpl", env))
       | Ast.Lnot Ast.True -> raise Unsat
       | _ -> ast2, env, var_info, step)
  in
  try `Unknown (loop step env ast) with
  | Unsat -> `Unsat
  | Sat (_, env) -> `Sat env
;;

let run_basic_simplify ast =
  log "Basic simplifications:\n%!";
  (*let ast = lower_strlen ast in*)
  let ast = lower_mod ast in
  (* let ast = SimplI.run_simplify ast in *)
  (* let ast = lower_exp ast in *)
  let __ _ = log "After strlen lowering:@,@[%a@]\n" Ast.pp_smtlib2 ast in
  if Ast.is_conjunct ast
  then (
    match basic_simplify [ 1 ] Env.empty ast with
    | `Sat env -> `Sat ("presimpl", env)
    | `Unsat -> `Unsat
    | `Unknown (ast, e, _, _) -> `Unknown (ast |> shrink_variables, e))
  else `Unknown (ast, Env.empty)
;;

let get_range () =
  let ans =
    List.init
      (1 + Config.under2_config.amax - Config.under2_config.amin)
      (( + ) Config.under2_config.amin)
  in
  assert (
    List.for_all
      (fun x -> x >= Config.under2_config.amin && x <= Config.under2_config.amax)
      ans);
  ans
;;

let subst env ast =
  let (module S : SYM_SUGAR_AST) = make_main_symantics env in
  apply_symantics_unsugared (module S) ast
;;

let try_under2_heuristics env ast =
  let temp_env = ref env in
  let module Rewrite = struct
    include Id_symantics

    let mul terms =
      let aux = function
        | (Ast.Eia.Atom (Var _) | Pow (Const _, _) | Ast.Eia.Const _) as term -> term
        | term ->
          let x = gensym ~prefix:"%under2" () in
          temp_env := Env.extend_int_exn !temp_env x term;
          Ast.Eia.atom (Ast.var x Ast.I)
      in
      let terms = List.map aux terms in
      Id_symantics.mul (List.map aux terms)
    ;;
  end
  in
  let env = !temp_env in
  let ast : Ast.t = apply_symantics_unsugared (module Rewrite) ast in
  let under2vars = find_vars_for_under2 ast in
  log
    "vars_for_under2: %a\n%!"
    Format.(pp_print_list pp_print_string)
    (Base.Set.to_list under2vars);
  log "@[%a@]" (Env.pp ~title:"env = ") env;
  log "ast = @[%a@]" Ast.pp_smtlib2 ast;
  let ( let* ) xs f = List.concat_map f xs in
  let _k = 0 in
  let envs =
    match Config.under2_config.flat with
    | n when n < 0 -> failwith "bad config"
    | 0 ->
      let all_as = get_range () in
      log
        "all as: @[%a@]\n%!"
        Format.(pp_print_list ~pp_sep:(fun ppf () -> fprintf ppf " ") pp_print_int)
        all_as;
      Base.Set.Poly.fold
        ~f:(fun acc name ->
          let* a = all_as in
          let* acc, phs = acc in
          let u = gensym ~prefix:"%under2" () in
          (*if Env.is_absent_key name env then*)
          [ Env.extend_int_exn acc name Id_symantics.(add [ pow2var u; const a ]), phs ]
          (*else
            [ Env.set_int_exn acc name Id_symantics.(add [ pow2var u; const a ]), (Ast.eia (Ast.Eia.eq (Env.lookup_int_exn name env) (Ast.Eia.atom (Ast.var name Ast.I)) Ast.I )) :: phs ]*))
        ~init:[ env, [] ]
        under2vars
    | 1 ->
      let all_as = get_range () in
      log
        "all as: @[%a@]\n%!"
        Format.(pp_print_list ~pp_sep:(fun ppf () -> fprintf ppf " ") pp_print_int)
        all_as;
      Base.Set.Poly.fold
        ~f:(fun acc name ->
          let* a = all_as in
          let* acc, phs = acc in
          let u = gensym ~prefix:"%under2" () in
          let v = gensym ~prefix:"%under2" () in
          [ ( Env.extend_int_exn
                acc
                name
                Id_symantics.(
                  Ast.Eia.Add
                    [ pow2var u; Ast.Eia.Mul [ const (-1); pow2var v ]; const a ])
            , Id_symantics.(prj (leq (var v) (var u))) :: phs )
          ])
        ~init:[ env, [] ]
        under2vars
    | n ->
      Base.Set.Poly.fold
        ~f:(fun acc name ->
          let* acc, phs = acc in
          let vars = List.init (1 + n) (fun _ -> gensym ~prefix:"%under2" ()) in
          let sum =
            List.mapi
              (fun i u ->
                 if i mod 2 = 1
                 then Id_symantics.(mul [ const (-1); pow2var u ])
                 else Id_symantics.(pow2var u))
              vars
          in
          let constraints =
            List.fold_right
              (fun v (oldv, acc) ->
                 let v = Id_symantics.var v in
                 v, Id_symantics.(prj (leq oldv v)) :: acc)
              vars
              Id_symantics.(const 0, [])
            |> snd
          in
          [ Env.extend_int_exn acc name (Ast.Eia.Add sum), constraints @ phs ])
        ~init:[ env, [] ]
        under2vars
  in
  List.map
    (fun (e, phs) ->
       let (module Symantics) = make_main_symantics e in
       apply_symantics (module Symantics) (Symantics.land_ (ast :: phs)))
    envs
;;

let check_nia ast =
  (* log "ast1=@[%a@]" Ast.pp_smtlib2 ast; *)
  let module M = struct
    include Id_symantics

    let pow_minus_one t = add [ const 1; mul [ const (-2); mod_ t (Z.of_int 2) ] ]
  end
  in
  let ast = apply_symantics_unsugared (module M) ast in
  let ast = lower_mod ast in
  (* log "ast2=@[%a@]" Ast.pp_smtlib2 ast; *)
  let ph = apply_symantics (make_smtml_symantics Utils.Map.empty) ast in
  log "Into Z3 goes: @[%a@]\n%!" Smtml.Expr.pp ph;
  let solver =
    Smtml.Z3_mappings.Solver.make
      ~logic:Smtml.Logic.QF_NIA
      ()
      ~params:Smtml.Params.(default () $ (Timeout, 200000))
  in
  Smtml.Z3_mappings.Solver.reset solver;
  match Smtml.Z3_mappings.Solver.check solver ~assumptions:[ ph ] with
  | `Sat -> `Sat
  | `Unsat -> `Unsat
  | `Unknown -> `Unknown
;;

let simpl bound ast =
  let prepare_choices env var_info =
    let ( let* ) xs f = List.concat_map f xs in
    let choice1 = List.init (bound + 1) Fun.id in
    Base.Set.Poly.fold
      ~f:(fun acc name ->
        let* v = choice1 in
        let* acc = acc in
        [ Env.extend_int_exn acc name Ast.Eia.(Const (Z.of_int v)) ])
      ~init:[ env ]
      var_info.Info.exp
  in
  let on_env step env =
    (* log "step: %a. env = %a\n" pp_step step Env.pp env; *)
    let (module Symantics) = make_main_symantics env in
    let ast_spec = apply_symantics (module Symantics) ast in
    match basic_simplify step env ast_spec with
    | `Unsat -> `Unknown
    | `Sat env -> raise (Underapprox_fired env)
    | `Unknown (ast, env, _info, step) ->
      let var_info = apply_symantics (module Who_in_exponents) ast_spec in
      let ast_spec = flatten var_info ast_spec in
      let ast_spec = apply_symantics (module Symantics) ast_spec in
      let __ () =
        log "step: %a. flattened ast = %a\n" pp_step step Ast.pp_smtlib2 ast_spec
      in
      (match check_errors ast_spec with
       | [] ->
         let ph = apply_symantics (make_smtml_symantics Utils.Map.empty) ast_spec in
         let solver = Smtml.Z3_mappings.Solver.make ~logic:Smtml.Logic.LIA () in
         Smtml.Z3_mappings.Solver.reset solver;
         (match Smtml.Z3_mappings.Solver.check solver ~assumptions:[ ph ] with
          | `Sat ->
            Printf.eprintf
              "The model could be not fully populated. %s %d\n%!"
              __FILE__
              __LINE__;
            raise (Underapprox_fired env)
          | `Unsat | `Unknown -> `Unknown)
       | errors ->
         log "%d errors found" (List.length errors);
         Format.printf "@[<v>%a@]\n%!" (Format.pp_print_list pp_error) errors;
         `Errors)
  in
  let loop (env : Env.t) ast =
    match basic_simplify [ 1 ] env ast with
    | `Unsat -> raise Unsat
    | `Sat env -> raise (Sat ("", env))
    | `Unknown (ast, env, _, _) when bound <= 0 -> ast, env
    | `Unknown (ast, env, _var_info, step) ->
      let ast = flatten _var_info ast in
      let var_info = apply_symantics (module Who_in_exponents) ast in
      let all_choices = prepare_choices env var_info in
      assert (all_choices <> []);
      let verdicts = List.mapi (fun i -> on_env (i :: step)) all_choices in
      let is_error = function
        | `Errors -> true
        | `Unknown -> false
      in
      if verdicts <> [] && List.for_all is_error verdicts
      then (
        match check_errors ast with
        | [] ->
          Printf.eprintf "Something weird: no errors. %s %d\n%!" __FILE__ __LINE__;
          raise (Error (ast, []))
        | errors -> raise (Error (ast, errors)));
      ast, env
  in
  let ast, env = loop Env.empty ast in
  (* Underapprox I *)
    match if bound >= 0 then Underapprox.check bound ast else `Unknown ast with
    | `Sat (reason, e) -> `Sat (reason, Env.merge_exn e env)
    | `Unsat _ -> `Unsat
    | `Unknown _ ->
      (try
         match check_errors ast with
         | [] -> `Unknown ast
         | errrs when Config.get_flat () < 0 ->
           `Error (ast, Base.List.dedup_and_sort ~compare:Stdlib.compare errrs)
         | errrs ->
           (* Underapprox II *)
           (* TODO(Kakadu): enrich environment  *)
           let env = Env.empty in
           log "%s %d" __FILE__ __LINE__;
           let asts = try_under2_heuristics env ast in
           let asts =
             List.filter_map
               (fun ast ->
                  match basic_simplify [ 1 ] env ast with
                  | `Unsat -> None
                  | `Sat env -> raise (Underapprox_fired env)
                  | `Unknown (ast, _, _, _) ->
                    let var_info = apply_symantics (module Who_in_exponents) ast in
                    let ast = flatten var_info ast in
                    (match check_errors ast with
                     | [] -> Some ast
                     | errors ->
                       log "Bad AST: @[%a]" Ast.pp_smtlib2 ast;
                       Format.printf
                         "@[<v>%a@]\n%!"
                         (Format.pp_print_list pp_error)
                         errors;
                       None))
               asts
           in
           `Underapprox asts
       with
       | Unsat -> `Unsat
       | Underapprox_fired env -> `Sat ("underappox2", env)
       | Sat (reason, env) -> `Sat (reason, env)
       | Error (ast, errs) -> `Error (ast, errs))
;;

(* let run_under1 bound ast : [> `Sat of string * Env.t | `Unknown ] =
  if bound >= 0
  then (
    match Underapprox.check bound ast with
    | `Sat s -> `Sat s
    | `Unsat s -> `Unsat s
    | `Unknown _ -> `Unknown)
  else `Unknown
;; *)

let run_under2 env ast =
  let asts = try_under2_heuristics env ast in
  let asts =
    List.filter_map
      (fun ast ->
         match basic_simplify [ 1 ] env ast with
         | `Unsat -> None
         | `Sat env -> raise_notrace (Underapprox_fired env)
         | `Unknown (ast, _, _, _) ->
           let var_info = apply_symantics (module Who_in_exponents) ast in
           let ast = flatten var_info ast in
           (match check_errors ast with
            | [] -> Some ast
            | errors ->
              log "Bad AST: @[%a]" Ast.pp_smtlib2 ast;
              Format.printf "@[<v>%a@]\n%!" (Format.pp_print_list pp_error) errors;
              None))
      asts
  in
  `Underapprox asts
;;

let rewrite_concats { Info.all; _ } =
  let module Map = Base.Map.Poly in
  let gensym1 = gensym in
  let rec gensym () =
    let ans = gensym1 ~prefix:"%concat" () in
    if Base.Set.Poly.mem all ans then gensym () else ans
  in
  let extra_ph = ref [] in
  let extend v other =
    extra_ph := Id_symantics.eqz (Id_symantics.var v) other :: !extra_ph
  in
  let var_or_const x =
    match x with
    | Ast.Eia.Str_const _ | Ast.Eia.Atom (Ast.Var (_, Ast.S)) -> true
    | _ -> false
  in
  let module Pre = struct
    include Id_symantics

    let split lhs rhs nfa =
      let rec helper lhs rhs nfa =
        let nfas : (NfaS.t * NfaS.t) list = NfaS.split nfa in
        match lhs, rhs with
        | x, y when var_or_const x && var_or_const y ->
          List.map
            (fun (nfa, nfa') ->
               [ Id_symantics.in_re_raw x nfa; Id_symantics.in_re_raw y nfa' ])
            nfas
        | x, Ast.Eia.Concat (lhs1, rhs1) ->
          List.concat
            (List.map
               (fun (nfa, nfa') ->
                  let nfas' = helper lhs1 rhs1 nfa' in
                  List.map (fun conj -> Id_symantics.in_re_raw x nfa :: conj) nfas')
               nfas)
        | Ast.Eia.Concat (lhs1, rhs1), y ->
          List.concat
            (List.map
               (fun (nfa, nfa') ->
                  let nfas' = helper lhs1 rhs1 nfa in
                  List.map (fun conj -> Id_symantics.in_re_raw y nfa' :: conj) nfas')
               nfas)
        | _ -> raise Exit
      in
      let nfas = List.map (fun conj -> Ast.land_ conj) (helper lhs rhs nfa) in
      Ast.lor_ nfas
    ;;

    (* (List.map
                 (fun nfas -> [Id_symantics.in_re_raw x nfa'] @ nfas)
                 (helper lhs1 rhs1 nfa')) *)
    let eq_str l r =
      match l, r with
      | Ast.Eia.Str_const s, Ast.Eia.Concat (lhs, rhs)
      | Ast.Eia.Concat (lhs, rhs), Ast.Eia.Str_const s ->
        split lhs rhs (NfaS.of_regex (Regex.str_to_re s))
      | lhs, rhs -> Id_symantics.eq_str lhs rhs
    ;;

    let in_re l regex =
      match l with
      | Ast.Eia.Concat (lhs, rhs) -> split lhs rhs (NfaS.of_regex regex)
      | str -> Id_symantics.in_re l regex
    ;;

    let rec str_len str =
      match str with
      | Ast.Eia.Concat (lhs, rhs) -> Id_symantics.add [ str_len lhs; str_len rhs ]
      | str -> Id_symantics.str_len str
    ;;
  end
  in
  let module M_ = struct
    include Id_symantics

    let rec str_concat (lhs : str) (rhs : str) =
      let handle_concat (lhs : str) (rhs : str) =
        let u = gensym () in
        let v = gensym () in
        let lhs' = gensym () in
        let rhs' = gensym () in
        extend lhs' (Ast.Eia.Iofs lhs);
        extend rhs' (Ast.Eia.Iofs rhs);
        extend
          u
          (Ast.Eia.add
             [ Ast.Eia.mul [ Ast.Eia.Atom (Ast.var lhs' I); pow2var v ]
             ; Ast.Eia.atom (Ast.var rhs' I)
             ]);
        extend v (Ast.Eia.len rhs);
        Ast.Eia.sofi (Ast.Eia.Atom (Ast.var u I))
      in
      let do_concat lhs rhs = str_concat lhs rhs in
      match lhs, rhs with
      | Ast.Eia.Concat (lhs1, rhs1), Ast.Eia.Concat (lhs2, rhs2) ->
        do_concat (do_concat lhs1 rhs1) (do_concat lhs1 rhs1)
      | Ast.Eia.Concat (lhs1, rhs1), rhs2 -> handle_concat (do_concat lhs1 rhs1) rhs2
      | lhs1, Ast.Eia.Concat (lhs2, rhs2) -> handle_concat lhs1 (do_concat lhs2 rhs2)
      | lhs1, rhs1 -> handle_concat lhs1 rhs1
    ;;

    let prj = function
      | Ast.Land xs -> land_ (!extra_ph @ xs)
      | ph -> land_ (!extra_ph @ [ ph ])
    ;;
  end
  in
  let module Sym = struct
    include M_
    include FT_SIG.Sugar (M_)
  end
  in
  fun ph ->
    Sym.prj (apply_symantics_unsugared (module Pre) ph |> apply_symantics (module Sym))
;;

let rewrite_via_concat { Info.all; _ } =
  let module Map = Base.Map.Poly in
  let gensym1 = gensym in
  let rec gensym () =
    let ans = gensym1 ~prefix:"%substr" () in
    if Base.Set.Poly.mem all ans then gensym () else ans
  in
  let extra_ph = ref [] in
  let extend v other =
    extra_ph := Id_symantics.eqz (Id_symantics.var v) other :: !extra_ph
  in
  let extend_eq v other =
    extra_ph := Id_symantics.eq_str (Id_symantics.str_var v) other :: !extra_ph
  in
  let module M_ = struct
    include Id_symantics

    let str_substr (term : str) (offset : term) (len : term) =
      let svar v = Ast.Eia.atom (Ast.var v S) in
      let z1 = gensym () in
      let z2 = gensym () in
      let len_z1 = gensym () in
      let u = gensym () in
      let y = gensym () in
      let len_y = gensym () in
      extend len_y (Ast.Eia.len (svar y));
      extend len_y len;
      extend len_z1 (Ast.Eia.len (svar z1));
      extend len_z1 offset;
      extend_eq u (Ast.Eia.Concat (svar z1, Ast.Eia.Concat (svar y, svar z2)));
      extend_eq u term;
      svar y
    ;;

    let str_prefixof (s1 : str) (s2 : str) =
      let z1 = gensym () in
      Id_symantics.eq_str (Ast.Eia.Concat (s1, Ast.Eia.atom (Ast.var z1 S))) s2
    ;;

    let str_contains (s1 : str) (s2 : str) =
      let svar v = Ast.Eia.atom (Ast.var v S) in
      let z1 = gensym () in
      let z2 = gensym () in
      Id_symantics.eq_str (Ast.Eia.Concat (svar z1, Ast.Eia.Concat (s2, svar z2))) s1
    ;;

    let str_suffixof (s1 : str) (s2 : str) =
      let z1 = gensym () in
      Id_symantics.eq_str (Ast.Eia.Concat (Ast.Eia.atom (Ast.var z1 S), s1)) s2
    ;;

    let prj = function
      | Ast.Land xs -> land_ (!extra_ph @ xs)
      | ph -> land_ (!extra_ph @ [ ph ])
    ;;
  end
  in
  let module Sym = struct
    include M_
    include FT_SIG.Sugar (M_)
  end
  in
  fun ph -> Sym.prj (ph |> apply_symantics (module Sym))
;;

(*module Collect_alpha_ = struct
  module S = Base.Set.Poly

  type term = char S.t

  let ( ++ ) = S.union
  let empty = S.empty

  type ph = term
  type str = term
  type repr = ph

  let in_re _ re = Regex.symbols re |> List.map (fun a -> List.nth a 0) |> S.of_list
  let in_rei _ re = empty
  let str_len s = s
  let sofi s = s
  let iofs s = s
  let str_const _ = empty

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
  let pp_str = failwith "tbd"

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
  let eqz = ( ++ )
  let eq_str = ( ++ )
  let leq = ( ++ )
  let lt = ( ++ )

  let exists _ info =
    (* This place could be buggy when name clashes  *)
    info
  ;;

  let pow2var v = v;;

  let pow = ( ++ )
  let prj = Fun.id
  let unsupp _ = empty
end*)

(*module Collect_alpha :
  SYM_SUGAR with type repr = Collect_alpha_.repr and type ph = Collect_alpha_.repr =
struct
  include Collect_alpha_
  include FT_SIG.Sugar (Collect_alpha_)
end*)

let arithmetize ast =
  let pow_base = Ast.Eia.pow (Ast.Eia.const (Config.base ())) in
  let in_stoi v = Ast.in_stoi v ast in
  let atomi v = Ast.Eia.Atom (Ast.Var (v, Ast.I)) in
  let module NfaL = Nfa.Lsb (Nfa.Str) in
  let module Map = Base.Map.Poly in
  let is_regex : Ast.t -> bool = function
    | Ast.Eia (Eq (Ast.Eia.Atom (Ast.Var (s, S)), Ast.Eia.Str_const _, S))
    | Ast.Eia (InRe (Ast.Eia.Atom (Ast.Var (s, S)), Ast.S, _))
    | Ast.Eia (InReRaw (Ast.Eia.Atom (Ast.Var (s, S)), Ast.S, _)) -> true
    | Ast.Eia (InReRaw (Ast.Eia.Atom (Ast.Var (s, I)), Ast.I, _)) -> true
    | _ -> false
  in
  let collect_regexes ast =
    Ast.fold
      (fun acc -> function
         (* | Ast.Eia (Eq (lhs, Ast.Eia.Str_const str, S)) -> Ast.Eia.in_re TODO *)
         | Ast.Eia (Eq (Ast.Eia.Atom (Ast.Var (s, S)), Ast.Eia.Str_const str, S)) ->
           (s, Regex.str_to_re str |> NfaL.of_regex) :: acc
         | Ast.Eia (InRe (Ast.Eia.Atom (Ast.Var (s, S)), Ast.S, re)) ->
           (s, re |> NfaL.of_regex) :: acc
         | Ast.Eia (InReRaw (Ast.Eia.Atom (Ast.Var (s, S)), Ast.S, nfa)) ->
           (s, nfa) :: acc
         | Ast.Eia (InReRaw (Ast.Eia.Atom (Ast.Var (s, I)), Ast.I, nfa)) ->
           (s, nfa) :: acc
         | ast when is_regex ast -> failwith "unexpected"
         | _ -> acc)
      []
      ast
    |> Map.of_alist_multi
  in
  let fold_regexes ast =
    let ast_with_positive_regex =
      Ast.map
        (function
          | Lnot (Lnot ast) -> ast
          | Lnot (Ast.Eia (Eq (Ast.Eia.Atom (Ast.Var (s, S)), Ast.Eia.Str_const str, S)))
            ->
            Ast.Eia
              (InReRaw
                 ( Ast.Eia.Atom (Ast.Var (s, S))
                 , Ast.S
                 , Regex.str_to_re str |> NfaL.of_regex |> NfaL.invert ))
          | Lnot (Ast.Eia (InRe (Ast.Eia.Atom (Ast.Var (s, S)), Ast.S, re))) ->
            Ast.Eia
              (InReRaw
                 (Ast.Eia.Atom (Ast.Var (s, S)), Ast.S, re |> NfaL.of_regex |> NfaL.invert))
          | Lnot (Ast.Eia (InReRaw (Ast.Eia.Atom (Ast.Var (s, S)), Ast.S, nfa))) ->
            Ast.Eia (InReRaw (Ast.Eia.Atom (Ast.Var (s, S)), Ast.S, nfa |> NfaL.invert))
          | ast -> ast)
        ast
    in
    let regexes =
      Map.map
        ~f:(fun data ->
          List.fold_left
            (fun acc nfa -> NfaS.intersect nfa acc)
            (NfaCollection.Str.n ())
            data)
        (collect_regexes ast_with_positive_regex)
    in
    let ast_without_regex =
      Ast.map
        (function
          | ast when is_regex ast -> Ast.true_
          | ast -> ast)
        ast_with_positive_regex
    in
    let phs =
      if Map.existsi ~f:(fun ~key ~data -> NfaS.run data |> not) regexes
      then [ Ast.false_ ]
      else
        Map.fold
          ~init:[]
          ~f:(fun ~key:s ~data:nfa ph ->
            Ast.Eia (InReRaw (Ast.Eia.Atom (Ast.Var (s, S)), Ast.S, nfa)) :: ph)
          regexes
    in
    let ast = Ast.land_ (ast_without_regex :: phs) in
    ast, regexes
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
  let arithmetize ast =
    let rec arithmetize_term : 'a. 'a Ast.Eia.term -> Z.t Ast.Eia.term * Ast.Eia.t list =
      fun (type a) : (a Ast.Eia.term -> Z.t Ast.Eia.term * Ast.Eia.t list) -> function
        | Ast.Eia.Sofi s -> s, []
        | Iofs s -> arithmetize_term s
        | Len s ->
          let var, lenvar, phs =
            match s with
            | Ast.Eia.Atom (Ast.Var (var, _)) ->
              var, String.concat "" [ "strlen"; var ], []
            | non_var -> failwith "unreachable"
            (*let var = gensym ~prefix:"%arith_len" () in
            let non_var, phs = arithmetize_term non_var in
            ( var
            , String.concat "" [ "strlen"; var ]
            , Ast.Eia.eq (atomi var) non_var Ast.I :: phs )*)
          in
          let v = atomi lenvar in
          let s, phs' = arithmetize_term s in
          let phs = phs @ phs' in
          let phs = Ast.Eia.leq (Ast.Eia.const Z.zero) v :: phs in
          let phs =
            match in_stoi var, Map.mem (collect_regexes ast) var with
            | true, true -> Ast.Eia.rlen s (pow_base v) :: phs
            | true, false -> Ast.Eia.lt s (pow_base v) :: phs
            | false, other -> phs
          in
          v, phs
        | Str_const s -> Ast.Eia.const (Z.of_string s), []
        | Atom (Var (v, S)) -> atomi v, []
        | Concat (_, _) | At (_, _) | Substr (_, _, _) -> failwith "tbd"
        | (Const _ | Atom (Var (_, I))) as eia -> eia, []
        | Add ls ->
          let ls, phs = List.map arithmetize_term ls |> List.split in
          Ast.Eia.add ls, List.concat phs
        | Mul ls ->
          let ls, phs = List.map arithmetize_term ls |> List.split in
          Ast.Eia.mul ls, List.concat phs
        | Mod (lhs, rhs) ->
          let lhs, lhs_phs = arithmetize_term lhs in
          Ast.Eia.mod_ lhs rhs, lhs_phs
        | (Pow (lhs, rhs) | Bwand (lhs, rhs) | Bwor (lhs, rhs) | Bwxor (lhs, rhs)) as eia
          ->
          let build =
            match eia with
            | Pow _ -> Ast.Eia.pow
            | Bwand _ -> Ast.Eia.bwand
            | Bwor _ -> Ast.Eia.bwor
            | Bwxor _ -> Ast.Eia.bwxor
            | _ -> assert false
          in
          let lhs, lhs_phs = arithmetize_term lhs in
          let rhs, rhs_phs = arithmetize_term rhs in
          build lhs rhs, lhs_phs @ rhs_phs
        | Len2 _ -> failwith "unexpected len2"
    in
    let arithmetize_in_re s nfa =
      let strlens = String.concat "" [ "strlen"; s ] in
      let csds =
        NfaL.filter_map nfa (fun (label, q') ->
          if Nfa.Str.is_zero label then Option.none else Option.some (label, q'))
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
    let rec arithmetize_conj = function
      | Ast.Land [ x ] -> arithmetize_conj x
      | Ast.Land (x :: xs) ->
        List.fold_left cartesian (arithmetize_conj x) (List.map arithmetize_conj xs)
      | Ast.Eia (Leq (lhs, rhs)) ->
        let lhs', lhs_phs = arithmetize_term lhs in
        let rhs', rhs_phs = arithmetize_term rhs in
        [ Ast.land_ (Ast.Eia.leq lhs' rhs' :: (lhs_phs @ rhs_phs) |> List.map Ast.eia) ]
      | Ast.Eia (Eq (lhs, rhs, I)) ->
        let lhs', lhs_phs = arithmetize_term lhs in
        let rhs', rhs_phs = arithmetize_term rhs in
        [ Ast.land_ (Ast.Eia.eq lhs' rhs' Ast.I :: (lhs_phs @ rhs_phs) |> List.map Ast.eia)
        ]
      | Ast.Eia (Eq (lhs, rhs, S)) ->
        let lhs', lhs_phs = arithmetize_term lhs in
        let rhs', rhs_phs = arithmetize_term rhs in
        [ Ast.land_ (Ast.Eia.eq lhs' rhs' Ast.I :: (lhs_phs @ rhs_phs) |> List.map Ast.eia)
        ]
      | Ast.Eia (InRe (s, Ast.S, re)) ->
        (* Solve later: if var and has non-digits -> -1 or intersect with NFA for digits*)
        (* let digits = [ '0'; '1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'; Nfa.Str.u_eos ] in *)
        (* if Regex.symbols re |> List.exists (fun c -> List.mem (List.nth c 0) digits |> not) *)
        let s, phs = arithmetize_term s in
        let s, phs =
          match s with
          | Ast.Eia.Atom (Var (s, I)) -> s, phs
          | non_var ->
            let v = gensym ~prefix:"%arith_re" () in
            v, Ast.Eia.eq (atomi v) non_var Ast.I :: phs
        in
        if in_stoi s
        then
          [ Ast.land_
              (Ast.Eia (Ast.Eia.inre (atomi s) Ast.I Regex.digit)
               :: Ast.Eia (Ast.Eia.inre (atomi s) Ast.I re)
               :: (phs |> List.map Ast.eia))
          ; Ast.land_
              (Ast.Eia (Ast.Eia.inre (atomi s) Ast.I (Regex.digit |> Regex.mnot))
               :: Ast.Eia (Ast.Eia.eq (atomi s) (Ast.Eia.const Z.minus_one) Ast.I)
               :: Ast.Eia (Ast.Eia.inre (atomi s) Ast.I re)
               :: (phs |> List.map Ast.eia))
          ]
        else (
          let csds = arithmetize_in_re s (re |> NfaL.of_regex) in
          List.map
            (fun x ->
               Ast.land_
                 (x (* :: Ast.Eia (Ast.Eia.lt (atomi s) (pow_base (atomi strlens))) *)
                  :: (phs |> List.map Ast.eia)))
            csds)
      | Ast.Eia (InReRaw (s, S, nfa)) ->
        let s, phs = arithmetize_term s in
        let s, phs =
          match s with
          | Ast.Eia.Atom (Var (s, I)) -> s, phs
          | non_var ->
            let v = gensym ~prefix:"%arith_re_raw" () in
            v, Ast.Eia.eq (atomi v) non_var Ast.I :: phs
        in
        (* TODO: Add regular constraints with automata*)
        if in_stoi s
        then
          [ Ast.land_
              (Ast.Eia (Ast.Eia.inreraw (atomi s) Ast.I (Regex.digit |> NfaS.of_regex))
               :: Ast.Eia (Ast.Eia.inreraw (atomi s) Ast.I nfa)
               :: (phs |> List.map Ast.eia))
          ; Ast.land_
              (Ast.Eia
                 (Ast.Eia.inreraw
                    (atomi (String.concat "" [ "string"; s ]))
                    Ast.I
                    (Regex.digit |> NfaS.of_regex |> NfaS.invert))
               :: Ast.Eia (Ast.Eia.eq (atomi s) (Ast.Eia.const Z.minus_one) Ast.I)
               :: Ast.Eia
                    (Ast.Eia.inreraw (atomi (String.concat "" [ "string"; s ])) Ast.I nfa)
               :: (phs |> List.map Ast.eia))
          ]
        else (
          let csds = arithmetize_in_re s nfa in
          List.map (fun x -> Ast.land_ (x :: (phs |> List.map Ast.eia))) csds)
      | Ast.Eia (PrefixOf _ | SuffixOf _ | Contains _) -> failwith "tbd"
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
       | Unsupp _ -> failwith "unable to fold; unsupported constraint")
      |> fun res -> res
    in
    arithmetize_conj ast
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
  let var_info = apply_symantics (module Who_in_exponents) ast in
  match basic_simplify [ 1 ] Env.empty (ast |> rewrite_via_concat var_info) with
  | `Sat env -> `Sat ("presimpl", env)
  | `Unsat -> `Unsat
  | `Unknown (ast', e, _, _) ->
    let var_info = apply_symantics (module Who_in_exponents) ast' in
    let asts_n_regexes =
      ast' |> rewrite_concats var_info |> Ast.to_dnf |> List.map fold_regexes
    in
    `Unknown
      (List.concat_map
         (fun (ast, regexes) ->
            List.map
              (fun ast' ->
                 let ast', regexes' = fold_regexes ast' in
                 let regexes =
                   Map.merge
                     ~f:(fun ~key -> function
                        | `Left v -> Some v
                        | `Right v -> Some v
                        | `Both (v, v') -> Some (NfaS.intersect v v'))
                     regexes
                     regexes'
                 in
                 ast', regexes)
              (ast |> flatten |> arithmetize))
         asts_n_regexes)
;;

(* let distribute xs =
  let open Ast in
  List.fold_left
    (fun acc -> function
       | Eia.Add ys -> List.concat_map (fun zs -> List.map (fun h -> h :: zs) ys) acc
       | other -> List.map (fun x -> other :: x) acc)
    ([ [] ] : _ list list)
    xs
;; *)

(* let test_distr xs =
  let (module Main_symantics) = make_main_symantics Env.empty in
  let ans = distribute xs |> List.map Main_symantics.mul |> Main_symantics.add in
  Debug.printf "@[%a@]\n%!" Ast.pp_term_smtlib2 ans
;; *)

(* Outdated tests*)
(* let%expect_test _ =
  let (module Test_symantcs : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  test_distr Test_symantcs.[ const 5; add [ var "x"; var "y" ] ];
  [%expect "(+ (* 5 x) (* 5 y))"]
;;

let%expect_test _ =
  let (module Test_symantcs : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  test_distr Test_symantcs.[ const 5; add [ var "x"; var "y" ]; add [ var "z"; var "u" ] ];
  [%expect "(+ (* 5 u x) (* 5 u y) (* 5 x z) (* 5 y z))"]
;;

let%expect_test _ =
  let (module Test_symantcs : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  test_distr Test_symantcs.[ const 5; add [ var "x"; var "y" ]; add [ var "z"; const 2 ] ];
  [%expect "(+ (* 5 x z) (* 5 y z) (* 10 x) (* 10 y))"]
;; *)

let leq_simpl l r =
  let (module TS : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  let ans = TS.prj TS.(l <= r) in
  Format.printf "@[%a@]\n%!" Ast.pp_smtlib2 ans
;;

let%expect_test " -2x <= -7" =
  let (module TS : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  leq_simpl TS.(mul [ const (-2); var "x" ]) TS.(const (-7));
  [%expect "(<= (* (- 1) x) (- 4))"]
;;

let%expect_test " -2x <= -8" =
  let (module TS : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  leq_simpl TS.(mul [ const (-2); var "x" ]) TS.(const (-8));
  [%expect "(<= (* (- 1) x) (- 4))"]
;;

let%expect_test " -2x <= -1" =
  let (module TS : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  leq_simpl TS.(mul [ const (-2); var "x" ]) TS.(const (-1));
  [%expect "(<= (* (- 1) x) (- 1))"]
;;

(* let tracing_on =
  match Sys.getenv "CHRO_TRACE_OPT" with
  | exception Not_found -> false
  | "1" -> true
  | _ -> false
;; *)

(* let log ppf =
  if tracing_on
  then Format.kasprintf (Format.printf "%s%!") ppf
  else Format.ifprintf Format.std_formatter ppf
;; *)
