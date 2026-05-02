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

let ( -- ) i j =
  let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
  aux j []
;;

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
    | Concat xs as ans when Ast.Eia.is_concat_nontrivial xs ->
      Non_linear_string [ ans ] :: acc
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

type str_relop =
  | Eq
  | Neq

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
  val str_at : str -> term -> str
  val str_substr : str -> term -> term -> str
  val str_prefixof : str -> str -> ph
  val str_contains : str -> str -> ph
  val str_suffixof : str -> str -> ph

  (* String formulas *)
  val str_concat : str list -> str

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
  let str_concat xs = Ast.Eia.concat xs
  let mod_ = Ast.Eia.mod_
  let pow = Ast.Eia.pow
  let mul = Ast.Eia.mul
  let add = Ast.Eia.add
  let land_ xs = Ast.land_ xs
  let lor_ xs = Ast.lor_ xs
  let not = Ast.lnot
  let str_var s : str = Atom (Ast.Var (s, S))
  let str_const s : str = Ast.Eia.Str_const s
  let constz s = Ast.Eia.Const s
  let const s : term = constz (Z.of_int s)
  let str_at s a = Ast.Eia.at s a
  let str_substr s a b = Ast.Eia.substr s a b

  (* Formulas *)

  let var s = Ast.Eia.Atom (Ast.Var (s, I))
  let exists atoms ph = Ast.exists atoms ph
  let eqz l r = Ast.eia (Ast.Eia.eq l r Ast.I)
  let neqz l r = Ast.eia (Ast.Eia.neq l r Ast.I)
  let eq_str l r = Ast.eia (Ast.Eia.eq l r Ast.S)
  let neq_str l r = Ast.eia (Ast.Eia.neq l r Ast.S)
  let leq l r = Ast.eia (Ast.Eia.leq l r)
  let lt l r = Ast.eia (Ast.Eia.lt l r)
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
    | eia ->
      failwith (Format.asprintf "Not yet implemented int: %a" Ast.pp_term_smtlib2 eia)
  and helperS : string Ast.Eia.term -> S.str = function
    | Str_const s -> S.str_const s
    | Atom (Ast.Var (s, _)) -> S.str_var s
    | Sofi eia -> S.sofi (helperT eia)
    | At (s1, a) -> S.str_at (helperS s1) (helperT a)
    | Concat xs -> S.str_concat (List.map helperS xs)
    | Substr (s1, (Atom (Var (a, I)) as l), (Atom (Var (b, I)) as r)) ->
      S.str_substr (helperS s1) (helperT l) (helperT r)
    | Substr (s1, a, b) -> S.str_substr (helperS s1) (helperT a) (helperT b)
    | eia ->
      failwith (Format.asprintf "Not yet implemented str: %a" Ast.pp_term_smtlib2 eia)
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
  let str_concat = List.fold_left ( ++ ) empty
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

let gensym =
  let n = ref 0 in
  fun ?(prefix = "eee") () ->
    incr n;
    Printf.sprintf "%s%d" prefix !n
;;

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

    let compare_term = Eia.compare_term2
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

    let rec str_len = function
      | Ast.Eia.Str_const s -> Id_symantics.const (String.length s)
      | Ast.Eia.Concat xs -> add (List.map str_len xs)
      | s -> Id_symantics.str_len s
    ;;

    let str_concat xs =
      let xs = List.filter (( <> ) (Id_symantics.str_const "")) xs in
      match xs with
      | Ast.Eia.Str_const lhs :: Ast.Eia.Str_const rhs :: tl ->
        Id_symantics.str_concat
          (Id_symantics.str_const (String.concat "" [ lhs; rhs ]) :: tl)
      | [ hd ] -> hd
      | xs -> Id_symantics.str_concat xs
    ;;

    let str_len2 = function
      | Ast.Eia.Str_const s ->
        Id_symantics.constz Z.(pow (Config.base ()) (String.length s) - one)
      | s -> Id_symantics.str_len2 s
    ;;

    let iofs =
      let open Ast.Eia in
      function
      | Concat terms
        when List.exists
               (fun term ->
                  match term with
                  | Str_const s when Bool.not (String.for_all Base.Char.is_digit s) ->
                    true
                  | _ -> false)
               terms -> constz Z.minus_one
      | Str_const s -> begin
        match s with
        | "" -> constz Z.minus_one
        | s when String.for_all Base.Char.is_digit s -> constz (Z.of_string s)
        | _ -> constz Z.minus_one
      end
      | s -> iofs s
    ;;

    let sofi = function
      | Ast.Eia.Const s ->
        if Z.(s < zero)
        then Id_symantics.str_const ""
        else Id_symantics.str_const (Z.to_string s)
      | s -> Id_symantics.sofi s
    ;;

    let rlen term term' =
      match term with
      | Ast.Eia.Const c when Z.(c = minus_one) -> true_
      | _ -> Ast.Eia (Ast.Eia.RLen (term, term'))
    ;;

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
        if Base.String.is_substring ~substring:s2 s1
        then Id_symantics.true_
        else Id_symantics.false_
      | s1, Ast.Eia.Str_const s2 -> Id_symantics.in_re s1 (Regex.contains s2)
      | s1, s2 -> Ast.eia (Ast.Eia.contains s1 s2)
    ;;

    let str_suffixof s1 s2 =
      match s1, s2 with
      | Ast.Eia.Str_const s1, Ast.Eia.Str_const s2 ->
        if String.ends_with ~suffix:s1 s2 then Id_symantics.true_ else Id_symantics.false_
      | Ast.Eia.Str_const s1, s2 -> Id_symantics.in_re s2 (Regex.suffix s1)
      | s1, s2 -> Ast.eia (Ast.Eia.suffixof s1 s2)
    ;;

    let str_at s a =
      match s, a with
      | Ast.Eia.Str_const s, Ast.Eia.Const n ->
        (try Ast.Eia.Str_const (String.sub s (Z.to_int n) 1) with
         | _ -> Ast.Eia.Str_const "")
      | Ast.Eia.Str_const "", _ -> Ast.Eia.Str_const ""
      | _ -> Ast.Eia.at s a
    ;;

    let str_substr term offset len =
      match term, offset, len with
      | Ast.Eia.Str_const s, Ast.Eia.Const n, Ast.Eia.Const len ->
        let n = Z.to_int n in
        let len = Z.to_int len in
        (try Ast.Eia.Str_const (String.sub s n len) with
         | _ ->
           if n < String.length s
           then Ast.Eia.Str_const (String.sub s n (String.length s - n))
           else Ast.Eia.Str_const "")
      | Ast.Eia.Str_const "", _, _ -> Ast.Eia.Str_const ""
      | _ -> Ast.Eia.substr term offset len
    ;;

    let collect_inside_mul xs =
      List.fold_right
        (fun x acc : term list ->
           match x, acc with
           | Eia.Mul ys, _ -> ys @ acc
           | e, Eia.Add ss :: tl | Add ss, e :: tl ->
             add (List.map (fun x -> Eia.Mul [ x; e ]) ss) :: tl
           | Pow (base1, e1), Eia.Pow (base2, e2) :: tl when Stdlib.(base1 = base2) ->
             Eia.pow base1 (Eia.add [ e1; e2 ]) :: tl
           | Const c, Eia.Pow ((Const basec as base), Add (Const d :: ss)) :: tl
             when Z.(equal (abs c) basec) && d = Z.minus_one ->
             Eia.(Const Z.(c / basec)) :: Eia.Pow (base, add ss) :: tl
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
                 Z.(cacc / base), Eia.Pow (b, Eia.add sums) :: phacc
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
      | c, [ Add ss ] -> Eia.add (List.map (fun x -> Eia.Mul [ constz c; x ]) ss)
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

    let mod_ lhs rhs =
      match lhs, rhs with
      | Ast.Eia.Const lhs, rhs -> Id_symantics.constz (Z.( mod ) lhs rhs)
      | lhs, rhs -> Id_symantics.mod_ lhs rhs
    ;;

    let add xs =
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
      let fold_coeff c1 c2 term acc =
        if c1 = Z.(minus_one * c2)
        then acc
        else Eia.Mul [ Eia.Const Z.(c1 + c2); term ] :: acc
      in
      let rec fold_add = function
        | t1 :: t2 :: tl when Eia.equal t1 t2 ->
          fold_add (Eia.Mul [ Eia.Const Z.(of_int 2); t1 ] :: tl)
        | Eia.Mul [ Eia.(Const c1); t1 ] :: t2 :: tl when Eia.equal t1 t2 ->
          fold_add (fold_coeff c1 Z.one t1 tl)
        | t1 :: Mul [ Eia.(Const c2); t2 ] :: tl when Eia.equal t1 t2 ->
          fold_add (fold_coeff Z.one c2 t1 tl)
        | Mul [ Eia.(Const c1); t1 ] :: Mul [ Eia.(Const c2); t2 ] :: tl
          when Eia.equal t1 t2 -> fold_add (fold_coeff c1 c2 t1 tl)
        | t1 :: xs -> t1 :: fold_add xs
        | one_atom -> one_atom
      in
      match fold_and_sort Z.zero Z.( + ) (collect_inside_add xs) with
      | c, [] -> constz c
      | c, terms when Z.(c = zero) -> Ast.Eia.add (fold_add terms)
      | c, [ term ] when Z.(c = zero) -> term
      | c, terms -> Ast.Eia.add (constz c :: fold_add terms)
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

    let lor_ x = Ast.lor_ x

    let relop op l r =
      let ofop =
        match op with
        | Leq -> fun x y -> eia (Eia.leq x y)
        | Eq -> fun x y -> eia (Eia.eq x y I)
      in
      match l, r with
      | Eia.(Const l), Eia.(Const r) ->
        (match op with
         | Eq when Z.equal l r -> true_
         | Eq -> false_
         | Leq when l <= r -> true_
         | Leq -> false_)
      | Eia.(Add (Atom (Var (v1, _)) :: Mul [ Const c; Atom (Var (v2, _)) ] :: tl)), rhs
        when String.equal v1 v2 && c = Z.minus_one -> ofop (Eia.add tl) rhs
      | Eia.Add ls, Eia.Add rs -> ofop (add (ls @ List.map negate rs)) (constz Z.zero)
      | Eia.Add (Const c :: tl), Const n -> ofop (add tl) (constz Z.(n - c))
      | Const c, Add (Const n :: tl) -> ofop (add (List.map negate tl)) (constz Z.(n - c))
      | Const c, Add xs -> ofop (add (List.map negate xs)) (constz Z.(-c))
      | Pow (basel, powl), Pow (baser, powr) when basel = baser -> ofop powl powr
      | Eia.Pow (Eia.(Const base), Eia.Add (Const n :: etail)), _
        when Z.(n < zero) && Z.fits_int n ->
        ofop
          (Eia.Pow (Eia.(Const base), Eia.add etail))
          (mul [ pow (constz base) (constz (Z.abs n)); r ])
      | _ -> ofop l r
    ;;

    let trim op lhs rhs =
      let module S = String in
      let ofop result =
        match op, result with
        | Eq, true -> true_
        | Eq, false -> false_
        | Neq, true -> false_
        | Neq, false -> true_
      in
      let ofop2 =
        match op with
        | Neq -> Ast.Eia.neq
        | Eq -> Ast.Eia.eq
      in
      let open Ast.Eia in
      let rec trim_left lhs rhs =
        match lhs, rhs with
        | hd :: tl, hd' :: tl' when hd = hd' -> trim_left tl tl'
        | Str_const s :: tl, Str_const s' :: tl' when S.starts_with ~prefix:s' s ->
          let s = Str_const (S.sub s (S.length s') (S.length s - S.length s')) in
          trim_left (s :: tl) tl'
        | Str_const s' :: tl', Str_const s :: tl when S.starts_with ~prefix:s' s ->
          let s = Str_const (S.sub s (S.length s') (S.length s - S.length s')) in
          trim_left (s :: tl) tl'
        | lhs, rhs -> lhs, rhs
      in
      let trim_right lhs rhs =
        let lhs, rhs = List.rev lhs, List.rev rhs in
        let rec trim_right lhs rhs =
          match lhs, rhs with
          | hd :: tl, hd' :: tl' when hd = hd' -> trim_right tl tl'
          | Str_const s :: tl, Str_const s' :: tl' when S.ends_with ~suffix:s' s ->
            let s = Str_const (S.sub s 0 (S.length s - S.length s')) in
            trim_right (s :: tl) tl'
          | Str_const s' :: tl', Str_const s :: tl when S.ends_with ~suffix:s' s ->
            let s = Str_const (S.sub s 0 (S.length s - S.length s')) in
            trim_right (s :: tl) tl'
          | lhs, rhs -> lhs, rhs
        in
        let lhs, rhs = trim_right lhs rhs in
        let lhs, rhs = List.rev lhs, List.rev rhs in
        lhs, rhs
      in
      let lhs, rhs = trim_left lhs rhs in
      match trim_right lhs rhs with
      | [], [] -> ofop true
      | [], rhs -> ofop2 (Ast.Eia.concat rhs) (Id_symantics.str_const "") Ast.S |> Ast.eia
      | lhs, [] -> ofop2 (Ast.Eia.concat lhs) (Id_symantics.str_const "") Ast.S |> Ast.eia
      | Str_const a :: tl, Str_const b :: tl'
        when Stdlib.not (String.starts_with ~prefix:a b && String.starts_with ~prefix:b a)
        -> ofop false
      | lhs, rhs ->
        (match List.rev lhs, List.rev rhs with
         | Str_const a :: tl, Str_const b :: tl'
           when Stdlib.not (String.ends_with ~suffix:a b && String.ends_with ~suffix:b a)
           -> ofop false
         | _ ->
           (match op with
            | Eq -> eq_str (concat lhs) (concat rhs)
            | Neq -> neq_str (concat lhs) (concat rhs)))
    ;;

    let check_card lhs rhs =
      let exception Unrewritten_term_in_equation in
      try
        let open Ast.Eia in
        let alpha = if Option.is_some alpha then Option.get alpha else [] in
        let count a xs =
          List.fold_left
            (fun (c, terms) x ->
               match x with
               | Atom (Var (name, S)) -> c, name :: terms
               | Str_const s -> c + Base.String.count ~f:(fun x -> x = a) s, terms
               | term -> raise_notrace Unrewritten_term_in_equation)
            (0, [])
            xs
        in
        let contains lhs rhs =
          let sort = List.sort String.compare in
          let rec helper lhs rhs =
            match lhs, rhs with
            | [], _ -> true
            | _, [] -> false
            | x :: xs, y :: ys when x = y -> helper xs ys
            | x :: xs, y :: ys when x > y -> helper (x :: xs) ys
            | _ -> false
          in
          helper (sort lhs) (sort rhs)
        in
        List.exists
          (fun a ->
             let (c1, l), (c2, r) = count a lhs, count a rhs in
             (c1 < c2 && contains l r) || (c1 > c2 && contains r l))
          alpha
      with
      | Unrewritten_term_in_equation -> false
    ;;

    let eq_str lhs rhs =
      let open Ast.Eia in
      let as_list : string Ast.Eia.term -> string Ast.Eia.term list = function
        | Str_const _ as c -> [ c ]
        | Atom (Var _) as v -> [ v ]
        | Concat list -> list
        | (Substr _ | At _) as v -> [ v ]
        | _ -> []
      in
      let nielsen lhs rhs =
        match lhs, rhs with
        | x :: xs, y :: ys ->
          let fixedpoint =
            if List.is_empty xs || List.is_empty ys
            then (
              let check x u =
                match x, u with
                | Atom _, [] -> true
                | _ -> false
              in
              check x xs || check y ys)
            else (
              let ru, rv = xs |> List.rev |> List.hd, ys |> List.rev |> List.hd in
              Eia.eq_term rv x || Eia.eq_term ru y)
          in
          if fixedpoint
          then eq_str (concat lhs) (concat rhs)
          else (
            let u, v = concat xs, concat ys in
            let trival = land_ [ eq_str x y; eq_str u v ] in
            (* len(y) < len(x) *)
            let x' = Atom (Ast.var (gensym ~prefix:"%nielsen" ()) S) in
            let nielsen_x =
              land_ [ eq_str x (concat [ y; x' ]); eq_str (concat [ x'; u ]) v ]
            in
            (* len(x) < len(y) *)
            let y' = Atom (Ast.var (gensym ~prefix:"%nielsen" ()) S) in
            let nielsen_y =
              land_ [ eq_str y (concat [ x; y' ]); eq_str u (concat [ y'; v ]) ]
            in
            let split str y v =
              lor_
                (0 -- String.length str
                 |> List.map (fun x ->
                   String.sub str 0 x, String.sub str x (String.length str - x))
                 |> List.map (fun (s1, s2) ->
                   land_ [ eq_str y (str_const s1); eq_str v (str_const s2) ]))
            in
            let split_conc str u y v =
              lor_
                (0 -- String.length str
                 |> List.map (fun x ->
                   String.sub str 0 x, String.sub str x (String.length str - x))
                 |> List.map (fun (s1, s2) ->
                   land_
                     [ eq_str y (str_const s1); eq_str (concat [ str_const s2; u ]) v ]))
            in
            match x, y with
            | Atom _, Atom _ -> lor_ [ trival; nielsen_x; nielsen_y ]
            | Atom _, Str_const s when List.is_empty ys -> split s x u
            | Atom _, Str_const s -> lor_ [ trival; nielsen_x; split_conc s v x u ]
            | Str_const s, Atom _ when List.is_empty xs -> split s y v
            | Str_const s, Atom _ -> lor_ [ trival; nielsen_y; split_conc s u y v ]
            | _ -> eq_str (concat lhs) (concat rhs))
        | _ -> eq_str (concat lhs) (concat rhs)
      in
      let trim = trim Eq in
      match lhs, rhs with
      | Sofi (Atom (Var _) as l), Sofi (Atom (Var _) as r) -> Eia (Eq (l, r, I))
      | Str_const c1, Str_const c2 -> if String.equal c1 c2 then Ast.true_ else Ast.false_
      (* | (v, Ast.Eia.Str_const c | Ast.Eia.Str_const c, v)
        when Option.is_some alpha ->
        Id_symantics.in_re_raw v (Regex.str_to_re c |> NfaS.of_regex) *)
      | lhs, rhs when Eia.eq_term lhs rhs -> Ast.true_
      | lhs, rhs when check_card (as_list lhs) (as_list rhs) -> Ast.false_
      | Concat llhs, Concat lrhs
        when match llhs, lrhs with
             | x :: _, y :: _ when x = y -> true
             | Str_const _ :: _, Str_const _ :: _ -> true
             | _, _ -> false -> trim llhs lrhs
      | Concat llhs, Concat lrhs
        when match llhs |> List.rev, lrhs |> List.rev with
             | x :: _, y :: _ when x = y -> true
             | Str_const _ :: _, Str_const _ :: _ -> true
             | _, _ -> false -> trim llhs lrhs
      | Concat (x :: _ as llhs), y when x = y -> trim llhs [ y ]
      | x, Concat (y :: _ as lrhs) when x = y -> trim [ x ] lrhs
      | Concat llhs, Str_const _ ->
        (match llhs with
         | Str_const _ :: _ -> trim llhs [ rhs ]
         | _ -> nielsen llhs [ rhs ])
      | Str_const _, Concat lrhs ->
        (match lrhs with
         | Str_const _ :: _ -> trim [ lhs ] lrhs
         | _ -> nielsen [ lhs ] lrhs)
      | Concat llhs, Concat lrhs -> nielsen llhs lrhs
      | _ -> Id_symantics.eq_str lhs rhs
    ;;

    let neq_str l r =
      let trim = trim Neq in
      match l, r with
      | Ast.Eia.Str_const l, Ast.Eia.Str_const r ->
        if l <> r then Ast.true_ else Ast.false_
      | (v, Ast.Eia.Str_const c | Ast.Eia.Str_const c, v) when Option.is_some alpha ->
        Id_symantics.in_re_raw v (Regex.str_to_re c |> NfaS.of_regex |> NfaS.invert ?alpha)
      | eiat1, eiat2 when Ast.Eia.eq_term eiat1 eiat2 -> Ast.false_
      | Concat llhs, Concat lrhs
        when match llhs, lrhs with
             | x :: _, y :: _ when x = y -> true
             | Str_const _ :: _, Str_const _ :: _ -> true
             | _, _ -> false -> trim llhs lrhs
      | Concat llhs, Concat lrhs
        when match llhs |> List.rev, lrhs |> List.rev with
             | x :: _, y :: _ when x = y -> true
             | Str_const _ :: _, Str_const _ :: _ -> true
             | _, _ -> false -> trim llhs lrhs
      | Concat (x :: _ as llhs), y when x = y -> trim llhs [ y ]
      | x, Concat (y :: _ as lrhs) when x = y -> trim [ x ] lrhs
      | Concat (Str_const _ :: _ as llhs), Str_const _ -> trim llhs [ r ]
      | Concat llhs, Str_const _
        when match List.rev llhs with
             | Str_const _ :: _ -> true
             | _ -> false -> trim llhs [ r ]
      | Str_const _, Concat (Str_const _ :: _ as lrhs) -> trim [ l ] lrhs
      | Str_const _, Concat lrhs
        when match List.rev lrhs with
             | Str_const _ :: _ -> true
             | _ -> false -> trim [ l ] lrhs
      | _ -> Id_symantics.neq_str l r
    ;;

    let cancel_left op lhs rhs =
      let open Ast.Eia in
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
        gcd Z.zero atoms
      in
      let lhs' = List.filter (fun x -> Bool.not (List.mem x rhs)) lhs in
      let rhs' = List.filter (fun x -> Bool.not (List.mem x lhs)) rhs in
      let d = Z.gcd (gcd lhs') (gcd rhs') in
      op (simplify d lhs') (simplify d rhs')
    ;;

    let eqz l r =
      let open Ast.Eia in
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
      let open Ast.Eia in
      match l, r with
      | Add lhs, Add rhs -> cancel_left (relop Leq) lhs rhs
      | lhs, Add rhs -> cancel_left (relop Leq) [ lhs ] rhs
      | Add lhs, rhs -> cancel_left (relop Leq) lhs [ rhs ]
      | _ -> relop Leq l r
    ;;

    let lt l r = leq (add [ const 1; l ]) r

    let neqz l r =
      match l, r with
      | Ast.Eia.Const l, Ast.Eia.Const r -> if l <> r then Ast.true_ else Ast.false_
      | eiat1, eiat2 when Ast.Eia.eq_term eiat1 eiat2 -> Ast.false_
      | Add lhs, Add rhs -> cancel_left Id_symantics.neqz lhs rhs
      | lhs, Add rhs -> cancel_left Id_symantics.neqz [ lhs ] rhs
      | Add lhs, rhs -> cancel_left Id_symantics.neqz lhs [ rhs ]
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
        begin match
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
        match
          Regex.str_to_re str |> NfaStr.of_regex |> NfaStr.intersect re |> NfaStr.run
        with
        | true -> Ast.true_
        | false -> Ast.false_
      end
      | _ -> if NfaStr.run re then Id_symantics.in_re_raw s re else Ast.false_
    ;;

    let in_re_rawi s re =
      let module NfaStr = Nfa.Lsb (Nfa.Str) in
      match s with
      | Ast.Eia.(Const c) -> begin
        match re |> NfaStr.intersect (from_eia_nfa c) |> NfaStr.run with
        | true -> Ast.true_
        | false -> Ast.false_
      end
      | _ -> if NfaStr.run re then Id_symantics.in_re_rawi s re else Ast.false_
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
          (<= (+ (- 52) (exp 2 x) (exp 2 y)) 0)
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
          (<= (+ (- 2) x) 0)
          (<= (+ (- 52) x z) 0)
          (<= (+ 13 (* (- 5) x) (* (- 7) z) (* (- 8) (exp 2 y))) 0))

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

let find_vars_for_under2s ast =
  let module S = Base.Set.Poly in
  let open Ast.Eia in
  let fz = fun acc _ -> acc in
  let fs_left : string S.t -> string Ast.Eia.term -> _ =
    fun acc ->
    fun c ->
    match c with
    | Concat xs when Ast.Eia.is_concat_nontrivial xs ->
      let vars =
        List.filter_map
          (function
            | Atom (Var (s, S)) when not (String.starts_with ~prefix:"%" s) ->
              Option.some s
            | _ -> Option.none)
          xs
      in
      S.union acc (S.of_list vars)
    | t -> acc
  in
  let collect fs ast =
    Ast.fold
      (fun acc ->
         let open Ast.Eia in
         function
         | Eia (Eq (l, r, S)) ->
           (match l, r with
            | Str_const _, _ | _, Str_const _ -> acc
            | _, _ -> fold_term fz fs (fold_term fz fs acc r) l)
         | _ -> acc)
      S.empty
      ast
  in
  collect fs_left ast
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
  if Set.length (Ast.get_lin_vars ast2) < Set.length (Ast.get_lin_vars ast)
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
          (<= (+ (- 52) (exp 2 x) (exp 2 y)) 0)
          (<= (+ (- 3) x) 0))

        (and
          (<= (+ (- 52) (exp 2 x) (exp 2 y)) 0)
          (<= (+ (- 3) x) 0))
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
          (<= (+ (- 5000) (exp 2 x) (exp 2 y) (exp 10 u) (exp 10 v)) 0)
          (<= (+ x (* (- 1) y)) 0)
          (<= (+ (* (- 1) u) v) 0))

        (and
          (<= (+ (- 5000) (exp 2 x) (exp 2 y) (exp 10 u) (exp 10 v)) 0)
          (<= (+ x (* (- 1) y)) 0)
          (<= (+ (* (- 1) u) v) 0))
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
          (<= (+ (- 52) (exp 2 x) (exp 2 y)) 0)
          (<= (+ x (* (- 3) y)) 0))

        (and
          (<= (+ (- 52) (exp 2 x) (exp 2 y)) 0)
          (<= (+ x (* (- 3) y)) 0))
        |}]
    ;;
  end)
;;

let flatten { Info.all; _ } =
  let open Ast.Eia in
  let rec get_exp_max_height : 'a. 'a term -> int =
    fun (type a) (term : a term) ->
    match term with
    | Const _ | Atom (Var (_, I)) -> 0
    | Str_const _ | Atom (Var (_, S)) -> 0
    | Iofs ts | Len ts | Len2 ts -> get_exp_max_height ts
    | Sofi t -> get_exp_max_height t
    | Concat terms ->
      List.fold_left (fun acc term -> max acc (get_exp_max_height term)) 0 terms
    | Substr (term', term'', term''') ->
      max
        (max (get_exp_max_height term') (get_exp_max_height term''))
        (get_exp_max_height term''')
    | At (term', term'') -> max (get_exp_max_height term') (get_exp_max_height term'')
    | Add terms | Mul terms ->
      List.fold_left (fun acc term -> max acc (get_exp_max_height term)) 0 terms
    | Bwand (term', term'') | Bwor (term', term'') | Bwxor (term', term'') ->
      max (get_exp_max_height term') (get_exp_max_height term'')
    | Pow (term', term'') -> max (get_exp_max_height term') (get_exp_max_height term'' + 1)
    | Mod (t, _) -> get_exp_max_height t
  in
  let gensym1 = gensym in
  let rec gensym height =
    let ans = gensym1 ~prefix:("%" ^ Format.asprintf "%d" height ^ "flat_pow") () in
    if Base.Set.Poly.mem all ans then gensym height else ans
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
           let newv = gensym (get_exp_max_height e) in
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

type action =
  | Prop : string * Ast.typed_term -> action
  | PropAndPreserve : 'a Ast.Eia.term * 'a Ast.Eia.term * 'a Ast.kind -> action
  | Noprop

let rec eq_propagation (info : Info.t) ?soft ?multiple:bool (env : Env.t) (ast : Ast.t) =
  let open Ast in
  let (module S : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  let trivial_simplify eta = subst_term Env.empty eta in
  let noprop = Noprop in
  let is_simpl eia =
    Eia.fold_term
      (fun acc el ->
         match el with
         | Eia.At _ | Eia.Substr _ -> false
         | _ -> acc)
      (fun acc el ->
         match el with
         | Eia.At _ | Eia.Substr _ -> false
         | _ -> acc)
      true
      eia
  in
  let returni vn rhs =
    if is_simpl rhs
    then
      if Option.value ~default:false soft
      then PropAndPreserve (Ast.Eia.Atom (Ast.var vn Ast.I), rhs, Ast.I)
      else Prop (vn, Ast.TT (Ast.I, rhs))
    else noprop
  in
  let returns vn rhs =
    if is_simpl rhs
    then
      if Option.value ~default:false soft
      then PropAndPreserve (Ast.Eia.Atom (Ast.var vn Ast.S), rhs, Ast.S)
      else Prop (vn, Ast.TT (Ast.S, rhs))
    else noprop
  in
  let return2i lhs rhs =
    if is_simpl rhs then PropAndPreserve (lhs, rhs, Ast.I) else noprop
  in
  let trivial_string_propagations v = function
    | rhs -> returns v rhs
  in
  let term_propagations lhs =
    let cnt lhs =
      Ast.fold
        (fun acc -> function
           | Ast.Eia eia ->
             Ast.Eia.fold2
               (fun acc term -> if term = lhs then acc + 1 else acc)
               (fun acc _term -> acc)
               acc
               eia
           | ast -> acc)
        0
        ast
    in
    function
    | (Ast.Eia.Const _ | Atom _) as rhs when cnt lhs > 1 -> return2i lhs rhs
    | _ -> noprop
  in
  let helper info orig_ast env ast =
    let var_can_be_prop ?rhs v =
      Env.is_absent_key v env
      && Option.value
           ~default:true
           (Option.map (fun rhs -> Env.occurs_var env v rhs |> not) rhs)
      && not (Ast.in_strlen v ast)
      (*&& not
           (Ast.forsome
                 (function
                   | Ast.Eia eia ->
                     Ast.Eia.fold2
                       (fun acc -> function
                          | Ast.Eia.Pow (_, Ast.Eia.Atom (Ast.Var (v', Ast.I))) when v = v'
                            -> true
                          | _ -> acc)
                       (fun acc _ -> acc)
                       false
                       eia
                   | _ -> false)
                 ast)*)
    in
    let var_can_subst_complex v = var_can_be_prop v && not (Ast.in_strlen v ast) in
    let trivial_integer_propagations vn rhs =
      match rhs with
      | Ast.Eia.Const _
      | Iofs (Atom (Var _))
      | Len (Atom (Var _))
      | Len2 (Atom (Var _))
      | Sofi (Atom (Var _)) -> returni vn rhs
      | Atom (Ast.Var (vn', _)) when vn' <> vn ->
        if var_can_subst_complex vn then returni vn rhs else returni vn rhs
      | _ -> noprop
    in
    let advanced_integer_propagations (lhs : Z.t Ast.Eia.term) (rhs : Z.t Ast.Eia.term)
      : action
      =
      let (module S : SYM_SUGAR_AST) = make_main_symantics Env.empty in
      let single =
        fun c1 (Ast.Var (vn1, _) as v1) c2 (Ast.Var (vn2, _) as v2) rhs ->
        let is_bad v =
          (not (var_can_subst_complex v))
          || Info.is_in_expo v info
          || Info.is_in_string v info
        in
        try
          match is_bad vn1, is_bad vn2 with
          | false, _
            when Env.is_absent_key vn1 env
                 && Env.is_absent_key vn2 env
                 && Z.(equal c1 one) ->
            returni vn1 S.(add [ mul [ constz Z.minus_one; constz c2; Atom v2 ]; rhs ])
          | _, false
            when Env.is_absent_key vn2 env
                 && Env.is_absent_key vn2 env
                 && Z.(equal c2 one) ->
            returni vn2 S.(add [ mul [ constz Z.minus_one; constz c1; Atom v1 ]; rhs ])
          | _ -> noprop
          (* TODO(Kakadu): Support proper occurs check to workaround recursive substitutions *)
          (* MS: I am going to add try / catch for the Occurs exceeption *)
          (* Note: presence of key means we already simplified this variable in another equality *)
        with
        | Env.Occurs -> noprop
      in
      match lhs, rhs with
      | Atom (Var (vn, I)), Mul [ Const cl; Atom (Var (vn2, I)) ] when vn = vn2 ->
        (* (= ( * c v) vr) *)
        returni vn (Const Z.zero)
      | Mul [ Const cl; Atom (Var (vn, I)) ], Mul [ Const cl2; Atom (Var (vn2, I)) ]
        when vn = vn2 && cl <> cl2 -> returni vn (Const Z.zero)
      | Ast.Eia.Mul [ Const _; Atom (Var (vn, _)) ], (Const z as rhs)
        when Z.(equal z zero) ->
        (* (= ( * c v) 0) *)
        returni vn rhs
      | Mul [ Const cl; Atom (Var (vn, _)) ], Const cr when Z.(cr mod cl = zero) ->
        let rhs = Ast.Eia.(Const Z.(cr / cl)) in
        returni vn rhs
      | ( Add [ Atom (Var (v1n, _)); Mul [ Const c; (Atom (Var (v2n, _)) as v2) ] ]
        , Const z0 )
        when Z.(equal z0 zero) ->
        (* (= (+ v1 c*v2)) 0) *)
        if Env.occurs_var env v1n v2
        then noprop
        else (
          let new_rhs =
            if Z.(equal c minus_one) then v2 else Eia.Mul [ Const Z.(-c); v2 ]
          in
          returni v1n new_rhs)
      | Add [ Atom (Var (_, I) as v1); Atom (Var (_, I) as v2) ], rhs when v1 <> v2 ->
        (* (= (+ v1 v2) rhs) *)
        (* log "%s %d. ast = %a" __FILE__ __LINE__ Ast.pp_smtlib2 ast; *)
        single Z.one v1 Z.one v2 rhs
      | ( Add [ Atom (Var (vn1, _) as v1); Mul [ Const c2; Atom (Var (vn2, _) as v2) ] ]
        , rhs )
        when vn1 <> vn2 ->
        (* (= (+ v1 ( * c v2)) rhs) *)
        single Z.one v1 c2 v2 rhs
      | ( Add
            [ Mul [ Const c1; Atom (Var (vn1, _) as v1) ]
            ; Mul [ Const c2; Atom (Var (vn2, _) as v2) ]
            ]
        , rhs )
        when vn1 <> vn2 -> single c1 v1 c2 v2 rhs
      | Mul [ Const cl; Len (Atom (Var (vn, _))) ], Const cr
        when Z.(cr = zero) && Z.(cl <> zero) -> returns vn (S.str_const "")
      | Len (Atom (Var (vn, _))), Const cr when Z.(cr = zero) ->
        returns vn (S.str_const "")
      | _ -> noprop
    in
    let last_resort lhs rhs =
      match lhs, rhs with
      | Ast.Eia.Add xs, Ast.Eia.Const z
        when z = Z.zero
             && List.exists
                  (function
                    | Ast.Eia.Atom (Var (x, _)) -> var_can_be_prop x
                    | _ -> false)
                  xs ->
        let filtered = ref false in
        let vn = ref Option.none in
        let xs =
          List.filter
            (function
              | Ast.Eia.Atom (Var (vn', _)) when (not !filtered) && var_can_be_prop vn' ->
                vn := Option.some vn';
                filtered := true;
                false
              | _ -> true)
            xs
        in
        let vn = Option.get !vn in
        let rhs = Ast.Eia.mul [ Ast.Eia.const Z.minus_one; Ast.Eia.add xs ] in
        if
          Ast.get_vars (Ast.Eia.eq rhs (Ast.Eia.Const Z.zero) Ast.I) |> List.mem vn
          || Ast.in_chrob_len vn orig_ast
          || List.mem vn (Ast.get_exp_vars orig_ast)
        then noprop
        else returni vn rhs
      | Add xs, Const z
        when z = Z.zero
             && List.exists
                  (function
                    | Ast.Eia.Mul [ Ast.Eia.Const m_one; Ast.Eia.Atom (Var (x, _)) ]
                      when m_one = Z.minus_one -> var_can_be_prop x
                    | _ -> false)
                  xs ->
        let filtered = ref false in
        let vn = ref Option.none in
        let xs =
          List.filter
            (function
              | Ast.Eia.Mul [ Ast.Eia.Const m_one; Ast.Eia.Atom (Var (vn', _)) ]
                when m_one = Z.minus_one && (not !filtered) && var_can_be_prop vn' ->
                vn := Option.some vn';
                filtered := true;
                false
              | _ -> true)
            xs
        in
        let vn = Option.get !vn in
        let rhs = Ast.Eia.add xs in
        if
          Ast.get_vars (Ast.Eia.eq rhs (Ast.Eia.Const Z.zero) Ast.I) |> List.mem vn
          || Ast.in_chrob_len vn orig_ast
          || List.mem vn (Ast.get_exp_vars orig_ast)
        then noprop
        else returni vn rhs
      | _ -> noprop
    in
    let commut f lhs rhs =
      match f lhs rhs with
      | Noprop -> f rhs lhs
      | smth -> smth
    in
    let module Set = Base.Set.Poly in
    match ast with
    | Eia (Eia.Eq ((Eia.Atom (Var (vn, I)) as lhs), rhs, I)) when var_can_be_prop vn ~rhs
      -> begin
      match trivial_integer_propagations vn rhs with
      | Noprop -> begin advanced_integer_propagations lhs rhs end
      | smth -> smth
    end
    | Eia (Eia.Eq (rhs, Eia.Atom (Var (vn, I)), I)) when var_can_be_prop ~rhs vn ->
      trivial_integer_propagations vn rhs
    | Eia (Eia.Eq (Eia.Atom (Var (vn, S)), rhs, S)) when var_can_be_prop ~rhs vn ->
      trivial_string_propagations vn rhs
    | Eia (Eia.Eq (rhs, Eia.Atom (Var (vn, S)), S)) when var_can_be_prop ~rhs vn ->
      trivial_string_propagations vn rhs
    | Eia (Eia.Eq (lhs, rhs, I)) -> begin
      match commut advanced_integer_propagations lhs rhs with
      | Noprop -> begin
        match commut term_propagations lhs rhs with
        | Noprop -> last_resort lhs rhs
        | smth -> smth
      end
      | smth -> smth
    end
    (*| Eia (Eia.Eq (Add sums, Const rhs, I)) when Z.(zero = rhs) ->
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
                  | Eia eia'' when eia' <> eia'' && List.mem vn (Ast.get_vars eia'') ->
                    true
                  | _ -> false)
                orig_ast -> Some (extend_exn env v rhs)
    | Eia (Eia.Eq (lhs, Atom (Var (vn, _)), _))
      when match lhs with
           | Bwand _ | Bwor _ | Bwxor _ -> true
           | _ -> false -> None
    | Eia (Eia.Eq (lhs, Atom (Var (vn, _) as v), _) as eia')
      when var_can_subst_complex vn
           && (function
                | Eia eia'' when eia' <> eia'' && List.mem vn (Ast.get_vars eia'') -> true
                | _ -> false)
                orig_ast -> Some (extend_exn env v lhs)*)
    | eq -> noprop
  in
  let handle_action env ast = function
    | Prop (vn, Ast.TT (Ast.I, term)) ->
      let term = trivial_simplify term in
      Env.extend_int_exn env vn term, ast
    | Prop (vn, Ast.TT (Ast.S, term)) ->
      let term = trivial_simplify term in
      Env.extend_string_exn env vn term, ast
    | PropAndPreserve (term, rhs, Ast.I) ->
      let ast =
        Ast.map
          (function
            | Eia eia ->
              let eia =
                Ast.Eia.map2
                  Fun.id
                  (fun term' -> if term = term' then rhs else term')
                  Fun.id
                  eia
              in
              Ast.eia eia
            | el -> el)
          ast
      in
      let ast = Ast.land_ [ S.eqz term rhs; ast ] in
      env, ast
    | PropAndPreserve (term, rhs, Ast.S) ->
      let ast =
        Ast.map
          (function
            | Eia eia ->
              let eia =
                Ast.Eia.map2
                  Fun.id
                  Fun.id
                  (fun term' -> if term = term' then rhs else term')
                  eia
              in
              Ast.eia eia
            | el -> el)
          ast
      in
      let ast = Ast.land_ [ S.eq_str term rhs; ast ] in
      env, ast
    | Noprop -> env, ast
  in
  match ast with
  | Land xs ->
    let had_prop = ref false in
    let actions =
      List.fold_left
        (fun acc h ->
           match (helper info ast env) h with
           | Noprop -> acc
           | Prop _ as smth when !had_prop |> not ->
             had_prop := true;
             [ smth ]
           | Prop _ -> acc
           | PropAndPreserve _ as smth -> smth :: acc)
        []
        xs
    in
    let env, ph =
      List.fold_left (fun (env, ph) -> handle_action env ph) (env, ast) actions
    in
    let ph =
      match ph with
      | Ast.Land xs ->
        Ast.land_
          (List.map
             (function
               | Ast.Lor ys ->
                 Ast.lor_
                   (List.map
                      (fun y ->
                         let env, ph = eq_propagation ~soft:true info env y in
                         let (module Symantics) = make_main_symantics env in
                         apply_symantics_unsugared (module Symantics) ph)
                      ys)
               | el -> el)
             xs)
      | ph -> ph
    in
    env, ph
  | Ast.Lor ys ->
    ( env
    , Ast.lor_
        (List.map
           (fun y ->
              let env, ph = eq_propagation ~soft:true info env y in
              let (module Symantics) = make_main_symantics env in
              apply_symantics_unsugared (module Symantics) ph)
           ys) )
  | Eia _ ->
    let env, ph = handle_action env ast (helper info ast env ast) in
    env, ph
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
  [%expect "x -> (+ (* (- 2) y) z);"];
  test TS.(add [ var "x"; mul [ const 2; var "y" ] ] = mul [ var "z"; var "z" ]);
  [%expect "x -> (+ (* (- 2) y) (* z z));"];
  test ~exp:[ "x" ] TS.(add [ var "x"; var "y" ] = mul [ var "z"; var "z" ]);
  [%expect "x -> (+ (- y) (* z z));"];
  ()
;;

exception Underapprox_fired of Env.t
exception Str_Underapprox_fired of Env.t
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
  let str_concat = List.fold_left ( ++ ) empty
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
  let log =
    if step = [ 0 ] then fun ppf -> Format.ifprintf Format.std_formatter ppf else log
  in
  log "iter(%a)= @[%a@]" pp_step step Ast.pp_smtlib2 ast;
  let alpha = alpha_with_extra_char ast in
  log
    "Alphabet with extra char: %a\n%!"
    Format.(pp_print_list ~pp_sep:(fun ppf () -> fprintf ppf " ") pp_print_char)
    alpha;
  let rec loop step (env : Env.t) ast =
    let (module Symantics) = make_main_symantics ~alpha env in
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
    match Env.length env2 > Env.length env, Ast.equal ast ast2 with
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

let normalize eia =
  let open Ast.Eia in
  let rec loop eia =
    let (module Symantics) = make_main_symantics Env.empty in
    let rez = apply_symantics (module Symantics) eia in
    let eia2 = Symantics.prj rez in
    if Ast.equal eia eia2 then eia2 else loop eia2
  in
  match eia with
  | (Eq (_, _, I) | Neq (_, _, I) | Leq (_, _)) as constr ->
    (match loop (Ast.Eia constr) with
     | Ast.Eia normalized -> normalized
     | Lnot True -> Ast.Eia.leq (Ast.Eia.const Z.one) (Ast.Eia.const Z.zero)
     | True -> Ast.Eia.leq (Ast.Eia.const Z.zero) (Ast.Eia.const Z.one)
     | ast ->
       failwith
         (Format.asprintf
            "Unexpected non-integer constraint in normalization: %a"
            Ast.pp_smtlib2
            ast))
  | _ -> eia
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

let get_strings_range nfa length ?(exact = false) num =
  let max_len = Config.under_str_config.max_len in
  (if length < 0
   then NfaS.any_n_paths_range nfa ~len:max_len num
   else (
     match exact with
     | true -> NfaS.any_n_paths nfa ~len:length num
     | _ -> 0 -- length |> List.concat_map (fun x -> NfaS.any_n_paths nfa ~len:x num)))
  |> List.map (fun c -> List.to_seq c |> String.of_seq)
  |> List.map (fun c ->
    if String.length c > 0
    then String.sub c 0 (String.length c - 1)
    else c (* Format.printf ">>>>> %s\n%!" c; *))
  |> List.fast_sort (fun x y ->
    match String.length x - String.length y with
    | 0 -> String.compare x y
    | diff -> diff)
  |> fun x ->
  if length <= 0 && NfaS.re_accepts (String.to_seq "" |> List.of_seq) nfa
  then "" :: x
  else x
;;

let subst env ast =
  let (module S : SYM_SUGAR_AST) = make_main_symantics ~agressive:true env in
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
                  Ast.Eia.add
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
          [ Env.extend_int_exn acc name (Ast.Eia.add sum), constraints @ phs ])
        ~init:[ env, [] ]
        under2vars
  in
  List.map
    (fun (e, phs) ->
       let (module Symantics) = make_main_symantics e in
       apply_symantics (module Symantics) (Symantics.land_ (ast :: phs)))
    envs
;;

let check_nia env ast =
  let module Z3 = Smtml.Z3_mappings.Solver in
  let to_normal_env =
    Base.Map.Poly.fold ~init:Env.empty ~f:(fun ~key ~data acc ->
      let _ : Env.t = acc in
      let open Ast in
      Env.extend_exn acc (Var (key, I)) (Eia.Const (Z.of_int data)))
  in
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
    Z3.make
      ~logic:Smtml.Logic.QF_NIA
      ()
      ~params:Smtml.Params.(default () $ (Timeout, 200000) $ (Random_seed, 42))
  in
  Z3.reset solver;
  match Z3.check solver ~assumptions:[ ph ] with
  | `Sat ->
    (match Z3.model solver with
     | None -> assert false
     | Some m ->
       let e =
         Hashtbl.fold
           (fun k v acc ->
              let _ : Smtml.Symbol.t = k in
              match k.name, v with
              | Smtml.Symbol.Simple s, Smtml.Value.Int n ->
                Base.Map.Poly.add_exn acc ~key:s ~data:n
              | _ -> acc)
           (Smtml.Z3_mappings.values_of_model m)
           Base.Map.Poly.empty
       in
       `Sat (to_normal_env e))
  | `Unsat -> `Unsat
  | `Unknown -> `Unknown
;;

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
              Debug.printf "@[<v>%a@]\n%!" (Format.pp_print_list pp_error) errors;
              None))
      asts
  in
  `Underapprox asts
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
  let module Rewrite = struct
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
      extend_eq u (Ast.Eia.concat [ svar z1; svar y; svar z2 ]);
      extend_eq u term;
      svar y
    ;;

    let str_at (term : str) (pos : term) =
      let svar v = Ast.Eia.atom (Ast.var v S) in
      let z1 = gensym () in
      let z2 = gensym () in
      let len_z1 = gensym () in
      let u = gensym () in
      let y = gensym () in
      let len_y = gensym () in
      extend len_y (Ast.Eia.len (svar y));
      extend len_y (Ast.Eia.const Z.one);
      extend len_z1 (Ast.Eia.len (svar z1));
      extend len_z1 pos;
      extend_eq u (Ast.Eia.concat [ svar z1; svar y; svar z2 ]);
      extend_eq u term;
      svar y
    ;;

    let str_prefixof (s1 : str) (s2 : str) =
      let z1 = gensym () in
      Id_symantics.eq_str (Ast.Eia.concat [ s1; Ast.Eia.atom (Ast.var z1 S) ]) s2
    ;;

    let str_contains (s1 : str) (s2 : str) =
      let svar v = Ast.Eia.atom (Ast.var v S) in
      let z1 = gensym () in
      let z2 = gensym () in
      Id_symantics.eq_str (Ast.Eia.concat [ svar z1; s2; svar z2 ]) s1
    ;;

    let str_suffixof (s1 : str) (s2 : str) =
      let z1 = gensym () in
      Id_symantics.eq_str (Ast.Eia.concat [ Ast.Eia.atom (Ast.var z1 S); s1 ]) s2
    ;;

    let prj = function
      | Ast.Land xs -> land_ (!extra_ph @ xs)
      | ph -> land_ (!extra_ph @ [ ph ])
    ;;
  end
  in
  let rec loop ast =
    let ast' = Rewrite.prj (ast |> apply_symantics_unsugared (module Rewrite)) in
    if Ast.is_simpl ast' then ast' else loop ast'
  in
  fun ph -> loop ph
;;

(* let over_reg ast =
  let open Ast.Eia in
  let collect_consts =
    List.fold_left
      (fun acc term ->
         match term with
         | Str_const s -> s :: acc
         | _ -> acc)
      []
  in
  Ast.fold
    (fun acc -> function
       | Ast.Eia (Eq (lhs, rhs, S)) -> begin
         match lhs, rhs with
         | Concat (Str_const s :: tl), term | term, Concat (Str_const s :: tl) ->
           collect_consts tl
           |> List.map (fun s -> Id_symantics.in_re term (Regex.contains s))
           |> (fun constr -> Id_symantics.in_re term (Regex.prefix s) :: constr)
           |> List.fold_left (fun acc' constr -> constr :: acc') acc
         | Concat l, term | term, Concat l ->
           (match l |> List.rev with
            | Str_const s :: tl ->
              collect_consts tl
              |> List.map (fun s -> Id_symantics.in_re term (Regex.contains s))
              |> (fun constr -> Id_symantics.in_re term (Regex.suffix s) :: constr)
              |> List.fold_left (fun acc' constr -> constr :: acc') acc
            | _ ->
              collect_consts l
              |> List.map (fun s -> Id_symantics.in_re term (Regex.contains s))
              |> List.fold_left (fun acc' constr -> constr :: acc') acc)
         | _ -> acc
       end
       | ast -> acc)
    []
    ast
;; *)

let over_concat_len ast =
  let open Ast.Eia in
  let module OverStrLen = struct
    include Id_symantics

    let eq_str lhs rhs = land_ [ eq_str lhs rhs; eqz (len lhs) (len rhs) ]
  end
  in
  apply_symantics_unsugared (module OverStrLen) ast
;;

let under_str env alpha vars ast =
  let module Set = Base.Set.Poly in
  let module Map = Base.Map.Poly in
  let try_under_str vars alpha len env ast =
    if Base.Set.length vars = 0
    then []
    else (
      let ( let* ) xs f = List.concat_map f xs in
      let envs =
        let regexes =
          Map.map
            ~f:(fun data ->
              List.fold_left
                (fun acc nfa -> NfaS.intersect nfa acc)
                (NfaCollection.LsbStr.n ())
                data)
            (collect_regexes ast)
        in
        let all_as name =
          let alpha =
            alpha
            |> Set.of_list
            |> (fun x ->
            Seq.fold_left
              (fun acc digit -> Set.add acc digit)
              x
              (Regex.dec |> String.to_seq))
            |> Set.to_list
          in
          let nfa_alpha = Regex.all alpha |> NfaS.of_regex in
          let max_cnt = Config.under_str_config.max_cnt in
          let length = Ast.get_len name ast in
          let length, exact, count =
            match length >= 0, Map.mem regexes name with
            | true, other ->
              length, true, min max_cnt (Utils.pow ~base:(List.length alpha) length)
            | false, true -> length, false, max_cnt
            | _ -> len, false, max_cnt
          in
          let list =
            get_strings_range
              (if Ast.is_conjunct ast && Map.mem regexes name
               then Map.find_exn regexes name
               else nfa_alpha)
              length
              ~exact
              count
          in
          log
            "Strings for %s:\n %a\n%!"
            name
            Format.(
              pp_print_list pp_print_string ~pp_sep:(fun ppf () -> Format.fprintf ppf " "))
            list;
          list
        in
        Base.Set.Poly.fold
          ~f:(fun acc name ->
            let* s = all_as name in
            let* acc = acc in
            [ Env.extend_string_exn acc name (Ast.Eia.Str_const s) ])
          ~init:[ env ]
          vars
      in
      List.map
        (fun e ->
           let (module Symantics) = make_main_symantics e in
           (* Debug.printf "AST: %a\n%!" Ast.pp_smtlib2 ast;
         log "@[%a@]" (Env.pp ~title:"env = ") e; *)
           e, apply_symantics (module Symantics) ast)
        envs)
  in
  if Config.under_str_config.max_cnt < 0
  then Seq.empty
  else (
    let filter_asts =
      List.filter_map (fun (env, ast) ->
        (* log "After rewriting via concats:\n%!"; *)
        let var_info = apply_symantics (module Who_in_exponents) ast in
        match basic_simplify [ 0 ] env (ast |> rewrite_via_concat var_info) with
        | `Unsat -> None
        | `Sat env -> raise_notrace (Str_Underapprox_fired env)
        | `Unknown (ast, env, _, _) -> Some (ast |> over_concat_len, env))
    in
    let m = List.length vars in
    Seq.init (m * (Config.under_str_config.max_len + 1)) (fun x -> x / m, x mod m)
    |> Seq.map (fun (length, side) ->
      match side with
      | n when n >= 0 && n < m ->
        filter_asts (try_under_str (List.nth vars n) alpha length env ast)
      | other -> failwith "Unreachable: remainder is negative"))
;;

let split_concats ast =
  let module Map = Base.Map.Poly in
  let var_or_const x =
    match x with
    | Ast.Eia.Str_const _ | Ast.Eia.Atom (Ast.Var (_, Ast.S)) -> true
    | _ -> false
  in
  let simplify_in_re_raw x nfa =
    if NfaS.run nfa
    then [ [ Id_symantics.in_re_raw x nfa ] ]
    else [ [ Id_symantics.false_ ] ]
  in
  let module Pre = struct
    include Id_symantics

    let split xs nfa =
      let rec helper xs nfa =
        Debug.dump_nfa ~msg:"Before splitting: %s" NfaS.format_nfa nfa;
        let nfas : (NfaS.t * NfaS.t) list = NfaS.split nfa in
        Debug.printf "==================================================\n%!";
        match xs with
        | [ x; Ast.Eia.Str_const y ] ->
          Debug.dump_nfa ~msg:"Before splitting derivative %s" NfaS.format_nfa nfa;
          let nfa = NfaS.deriv nfa (String.to_seq y |> List.of_seq |> List.rev) in
          Debug.dump_nfa ~msg:"Splitting derivative %s" NfaS.format_nfa nfa;
          simplify_in_re_raw x nfa
        | [ Ast.Eia.Str_const x; y ] ->
          Debug.dump_nfa ~msg:"Before splitting derivative %s" NfaS.format_nfa nfa;
          let nfa = NfaS.deriv_final nfa (String.to_seq x |> List.of_seq) in
          Debug.dump_nfa ~msg:"Splitting derivative %s" NfaS.format_nfa nfa;
          simplify_in_re_raw y nfa
        | [ x; y ] when var_or_const x && var_or_const y ->
          List.map
            (fun (nfa, nfa') ->
               [ Id_symantics.in_re_raw x nfa; Id_symantics.in_re_raw y nfa' ])
            nfas
        | x :: tl ->
          List.concat
            (List.map
               (fun (nfa, nfa') ->
                  let nfas' = helper tl nfa' in
                  List.map (fun conj -> Id_symantics.in_re_raw x nfa :: conj) nfas')
               nfas)
        | _ -> raise Exit
      in
      let nfas = List.map (fun conj -> Ast.land_ conj) (helper xs nfa) in
      Ast.lxor_ nfas
    ;;

    (* (List.map
                 (fun nfas -> [Id_symantics.in_re_raw x nfa'] @ nfas)
                 (helper lhs1 rhs1 nfa')) *)
    let eq_str l r =
      match l, r with
      | Ast.Eia.Str_const s, Ast.Eia.Concat xs | Ast.Eia.Concat xs, Ast.Eia.Str_const s ->
        split xs (NfaS.of_regex (Regex.str_to_re s))
      | lhs, rhs -> Id_symantics.eq_str lhs rhs
    ;;

    let in_re l regex =
      match l with
      | Ast.Eia.Concat xs -> split xs (NfaS.of_regex regex)
      | str -> Id_symantics.in_re l regex
    ;;

    let rec str_len str =
      match str with
      | Ast.Eia.Concat xs -> Id_symantics.add (List.map str_len xs)
      | str -> Id_symantics.str_len str
    ;;
  end
  in
  apply_symantics_unsugared (module Pre) ast
;;

let extract_and_filter_unsupported_atomic_formulas ast =
  let string_contains_non_digit = String.exists (Fun.negate Base.Char.is_digit) in
  let is_unsupported_concat = function
    | Ast.Eia.Concat xs ->
      List.exists
        (function
          | Ast.Eia.Str_const s when string_contains_non_digit s -> true
          | _ -> false)
        xs
    | _ -> false
  in
  let is_unsupported_string_equalitiy = function
    | Ast.Eia.Eq (_, _, S) as eia ->
      Ast.Eia.fold2
        (fun acc _ -> acc)
        (fun acc term -> if is_unsupported_concat term then true else acc)
        false
        eia
    | _ -> false
  in
  let is_eia_unsupported = function
    | eia when is_unsupported_string_equalitiy eia -> true
    | _ -> false
  in
  let unsupported_atomic_formulas = ref [] in
  let rec aux =
    let open Ast in
    function
    | Eia eia as ast when is_eia_unsupported eia -> begin
      unsupported_atomic_formulas := ast :: !unsupported_atomic_formulas;
      false_
    end
    | Lnot (Eia eia) as ast when is_eia_unsupported eia -> begin
      unsupported_atomic_formulas := ast :: !unsupported_atomic_formulas;
      false_
    end
    | Lnot ast -> lnot (aux ast)
    | (True | Eia _ | Pred _ | Unsupp _) as ast -> ast
    | Land xs -> land_ (List.map aux xs)
    | Lor xs -> lor_ (List.map aux xs)
    | Exists (x, v) -> exists x (aux v)
  in
  let ast = aux ast in
  ast, !unsupported_atomic_formulas
;;

let run_string_simplify ast =
  let module Set = Base.Set.Poly in
  match basic_simplify [ 1 ] Env.empty ast with
  | `Sat env -> `Sat env
  | `Unsat -> `Unsat ast
  | `Unknown (ast', e, _, _) ->
    let vars =
      if Config.config.under_str_all
      then
        ast'
        |> Ast.get_str_vars
        |> List.filter (fun s -> not (String.starts_with ~prefix:"%" s))
        |> Utils.powerset
        |> List.fast_sort (fun x y -> List.length x - List.length y)
        |> List.map Set.of_list
      else ast' |> find_vars_for_under2s |> fun x -> [ x ]
    in
    let vars = List.rev vars in
    let alpha = collect_alpha ast' in
    let approxed_asts = ast' |> under_str e (Utils.with_extra_char alpha) vars in
    let var_info = apply_symantics (module Who_in_exponents) ast' in
    (* log "After rewriting via concats:\n%!"; *)
      (match
         basic_simplify [ 0 ] e (ast' |> rewrite_via_concat var_info |> over_concat_len)
       with
       | `Sat env -> `Sat env
       | `Unsat -> `Unsat ast'
       | `Unknown (ast, env, _, _) -> `Unknown (ast, env, approxed_asts))
;;

let run_basic_simplify ?(env = Env.empty) ast =
  log "Basic simplifications:\n%!";
  let ast = lower_mod ast in
  let __ _ = log "After strlen lowering:@,@[%a@]\n" Ast.pp_smtlib2 ast in
  if Ast.is_conjunct ast
  then (
    match basic_simplify [ 1 ] env ast with
    | `Sat env -> `Sat env
    | `Unsat -> `Unsat ast
    | `Unknown (ast, e, _, _) ->
      `Unknown (ast |> shrink_variables |> flatten Info.empty, e))
  else `Unknown (ast, Env.empty)
;;

let theory_lemmas map =
  let phs = Base.Map.keys map in
  let cartesian_product xs ys =
    List.mapi (fun i x -> List.drop (i + 1) ys |> List.map (fun y -> x, y)) xs
    |> List.concat
  in
  let variants =
    cartesian_product phs phs
    |> List.filter_map (fun (x, y) ->
      match basic_simplify [ 0 ] Env.empty (Ast.land_ [ x; y ]) with
      | `Unsat -> Some (Ast.land_ [ Base.Map.find_exn map x; Base.Map.find_exn map y ])
      | _ -> None)
  in
  Ast.land_ (List.map Ast.lnot variants)
;;

let arithmetize ast env =
  let module Set = Base.Set.Poly in
  assert (Ast.is_conjunct ast);
  let str_vars = Ast.collect_str_vars ast in
  (*let exception StrVar_In_Arithmetize in*)
  let strlens s = String.concat "" [ "strlen"; s ] in
  let pow_base = Ast.Eia.pow (Ast.Eia.const (Config.base ())) in
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
  let fold_regexes ast =
    assert (Ast.is_conjunct ast);
    let regexes =
      Map.map
        ~f:(fun data ->
          List.fold_left
            (fun acc nfa -> NfaS.intersect nfa acc)
            (NfaCollection.LsbStr.n ())
            data)
        (collect_regexes ast)
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
            Ast.Eia (InReRaw (Ast.Eia.Atom (Ast.Var (s, S)), Ast.S, nfa)) :: ph)
          regexes
    in
    let ast = Ast.land_ (ast_without_regex :: phs) in
    ast, regexes
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
             Id_symantics.eqz (Id_symantics.var v) (Ast.Eia.iofs strv)
             :: Id_symantics.leq (Ast.Eia.Const Z.zero) (Ast.Eia.iofs strv)
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
               | Ast.Eia.Concat xs
                 when List.exists
                        (function
                          | Ast.Eia.Atom (Var (s, S)) -> List.mem s vars
                          | _ -> false)
                        xs -> true
               | _ -> acc)
            false
        in
        let contains_non_digit_strconst =
          let is_nondigit s =
            String.to_seq s |> Seq.exists (Fun.negate Base.Char.is_digit)
          in
          Ast.Eia.fold_term
            (fun acc el -> acc)
            (fun acc el ->
               match el with
               | Ast.Eia.Str_const s -> is_nondigit s || acc
               | Ast.Eia.Concat xs ->
                 List.exists
                   (function
                     | Ast.Eia.Str_const s -> is_nondigit s || acc
                     | _ -> false)
                   xs
                 || acc
               | _ -> acc)
            false
        in
        function
        | s when contains_var str_vars s || contains_non_digit_strconst s ->
          Id_symantics.constz Z.minus_one
        | s -> Id_symantics.iofs s
      ;;
    end
    in
    let module ArConc = struct
      include Id_symantics

      let str_concat xs =
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
        let rec do_concat (xs : string Ast.Eia.term list) =
          match xs with
          | [ Ast.Eia.Str_const s; _ ]
            when String.for_all Base.Char.is_digit s |> Stdlib.not ->
            raise (Unsupp_concat s)
          | [ _; Ast.Eia.Str_const s ]
            when String.for_all Base.Char.is_digit s |> Stdlib.not ->
            raise (Unsupp_concat s)
          | [ lhs1; rhs1 ] -> handle_concat lhs1 rhs1
          | hd :: tl -> handle_concat hd (do_concat tl)
          | [] -> Id_symantics.str_const ""
        in
        try do_concat xs with
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
    fun ph ->
      ArConc.prj
        (ph
         |> apply_symantics_unsugared (module ArConcIofs)
         |> apply_symantics_unsugared (module ArConc))
      |> apply_symantics_unsugared (module ArConcIofs)
  in
  let arithmetize var_info ast : Ast.t =
    let (module M) = make_main_symantics Env.empty in
    let in_stoi v = Ast.in_stoi v ast in
    let in_stoi_or_concat v = Ast.in_stoi v ast || Ast.in_concat v ast in
    let rec arithmetize_term
      : 'a. string list -> 'a Ast.Eia.term -> Z.t Ast.Eia.term * Ast.Eia.t list
      =
      fun (type a)
        : (string list -> a Ast.Eia.term -> Z.t Ast.Eia.term * Ast.Eia.t list) ->
        function
        | str_vars ->
          (function
            | Ast.Eia.Sofi s -> arithmetize_term str_vars s
            | Iofs (Atom (Var (v, S))) when List.mem v str_vars ->
              Ast.Eia.const Z.minus_one, []
            | Iofs s -> arithmetize_term str_vars s
            | Len (Atom (Var (var, S))) ->
              let lenvar, phs = String.concat "" [ "strlen"; var ], [] in
              let v = atomi lenvar in
              let regexes = collect_regexes ast in
              let in_regex = Map.mem regexes in
              let phs =
                (match in_stoi var, List.mem var str_vars with
                 | true, false -> Ast.Eia.leq (Ast.Eia.const Z.one) v
                 | _, _ -> Ast.Eia.leq (Ast.Eia.const Z.zero) v)
                :: phs
              in
              let phs =
                if List.mem var str_vars
                then phs
                else (
                  match in_stoi var, in_regex var with
                  | true, true -> Ast.Eia.rlen (atomi var) (pow_base v) :: phs
                  | true, false -> Ast.Eia.lt (atomi var) (pow_base v) :: phs
                  | false, other -> phs)
              in
              v, phs
            | Len term ->
              let term', phs = arithmetize_term str_vars term in
              let lenvar, phs =
                Format.asprintf "strlen_%a" Ast.pp_term_smtlib2 term', []
              in
              let v = atomi lenvar in
              let phs = Ast.Eia.leq (Ast.Eia.const Z.zero) v :: phs in
              let phs =
                Ast.Eia.leq (pow_base v) term'
                :: Ast.Eia.lt term' (Mul [ Ast.Eia.const (Config.base ()); pow_base v ])
                :: phs
              in
              v, phs
            (* | Len _ -> failwith "Unsupported constraint in arithmetize_term" *)
            | Str_const s -> Ast.Eia.const (Z.of_string s), []
            | Atom (Var (v, S)) -> atomi v, []
            | (Concat _ | At (_, _) | Substr (_, _, _)) as term ->
              failwith
                (Format.asprintf
                   "Unexpected in arithmetize_term: %a"
                   Ast.Eia.pp_term
                   term)
            | (Const _ | Atom (Var (_, I))) as eia -> eia, []
            | Add ls ->
              let ls, phs =
                List.map (fun x -> arithmetize_term str_vars x) ls |> List.split
              in
              Ast.Eia.add ls, List.concat phs
            | Mul ls ->
              let ls, phs =
                List.map (fun x -> arithmetize_term str_vars x) ls |> List.split
              in
              Ast.Eia.mul ls, List.concat phs
            | Mod (lhs, rhs) ->
              let lhs, lhs_phs = arithmetize_term str_vars lhs in
              Ast.Eia.mod_ lhs rhs, lhs_phs
            | (Pow (lhs, rhs) | Bwand (lhs, rhs) | Bwor (lhs, rhs) | Bwxor (lhs, rhs)) as
              eia ->
              let build =
                match eia with
                | Pow _ -> Ast.Eia.pow
                | Bwand _ -> Ast.Eia.bwand
                | Bwor _ -> Ast.Eia.bwor
                | Bwxor _ -> Ast.Eia.bwxor
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
    let arithmetize_in_re s nfa : Ast.t =
      if nfa |> NfaL.run |> not
      then Ast.false_
      else (
        log "Arithmetizing regex ... for variable %s" s;
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
        |> Ast.lor_)
    in
    let rec arithmetize_conj str_vars : Ast.t -> Ast.t = function
      | Ast.Land xs -> Ast.land_ (List.map (fun x -> arithmetize_conj str_vars x) xs)
      | Ast.Eia (Leq (lhs, rhs)) ->
        let lhs', lhs_phs = arithmetize_term str_vars lhs in
        let rhs', rhs_phs = arithmetize_term str_vars rhs in
        Ast.land_ (Ast.Eia.leq lhs' rhs' :: (lhs_phs @ rhs_phs) |> List.map Ast.eia)
      | Ast.Eia (Eq (lhs, rhs, I)) ->
        let lhs', lhs_phs = arithmetize_term str_vars lhs in
        let rhs', rhs_phs = arithmetize_term str_vars rhs in
        Ast.land_ (Ast.Eia.eq lhs' rhs' Ast.I :: (lhs_phs @ rhs_phs) |> List.map Ast.eia)
      | Ast.Eia (Eq (lhs, rhs, S)) ->
        let lhs', lhs_phs = arithmetize_term str_vars lhs in
        let rhs', rhs_phs = arithmetize_term str_vars rhs in
        Ast.land_ (Ast.Eia.eq lhs' rhs' Ast.I :: (lhs_phs @ rhs_phs) |> List.map Ast.eia)
      | Ast.Eia (Neq (lhs, rhs, I)) ->
        let lhs', lhs_phs = arithmetize_term str_vars lhs in
        let rhs', rhs_phs = arithmetize_term str_vars rhs in
        Ast.land_ (Ast.Eia.neq lhs' rhs' Ast.I :: (lhs_phs @ rhs_phs) |> List.map Ast.eia)
      | Ast.Eia (Neq (lhs, rhs, S)) ->
        let lhs', lhs_phs = arithmetize_term str_vars lhs in
        let rhs', rhs_phs = arithmetize_term str_vars rhs in
        Ast.land_ (Ast.Eia.neq lhs' rhs' Ast.I :: (lhs_phs @ rhs_phs) |> List.map Ast.eia)
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
        (match in_stoi s, List.mem s str_vars with
         | true, false ->
           Ast.land_
             (Ast.Eia (Ast.Eia.inreraw (atomi s) Ast.I nfa) :: (phs |> List.map Ast.eia))
         | _ ->
           arithmetize_in_re s nfa
           |> fun ast' -> Ast.land_ (ast' :: (phs |> List.map Ast.eia)))
      | Ast.Eia (PrefixOf _ | SuffixOf _ | Contains _) -> failwith "Unexpected constraint"
      | Ast.Unsupp s -> Ast.Unsupp s
      | _ as non_eia -> non_eia
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
    |> fun ast ->
    Ast.map
      (function
        | Ast.Eia (Ast.Eia.RLen (Ast.Eia.Atom (Ast.Var (s, _)), rhs))
          when var_appears_as_string s ast ->
          Ast.eia
            (Ast.Eia.rlen
               (Ast.Eia.atom (Ast.Var (String.concat "" [ "string"; s ], Ast.I)))
               rhs)
        | ast -> ast)
      ast
  in
  let unfold_neq var_info ast regexes =
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
    |> fun ast ->
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
    ast, !posts'
  in
  let var_info = apply_symantics (module Who_in_exponents) ast in
  let alpha = alpha_with_extra_char ast in
  let (module Symantics) = make_main_symantics ~alpha env in
  let asts_n_regexes =
    ast
    (*|> split_concats var_info*)
    (*|> Ast.to_dnf*)
    (*|> List.map *) |> apply_symantics (module Symantics)
    |> fold_regexes
  in
  asts_n_regexes
  |> (fun (ast, regexes) ->
  arithmetize var_info ast
  |> fun ast' ->
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
  ast', regexes)
  |> fun (a, b) -> unfold_neq var_info a b |> fun (a, a') -> a, env, a', b
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
  [%expect "(<= (+ 4 (* (- 1) x)) 0)"]
;;

let%expect_test " -2x <= -8" =
  let (module TS : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  leq_simpl TS.(mul [ const (-2); var "x" ]) TS.(const (-8));
  [%expect "(<= (+ 4 (* (- 1) x)) 0)"]
;;

let%expect_test " -2x <= -1" =
  let (module TS : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  leq_simpl TS.(mul [ const (-2); var "x" ]) TS.(const (-1));
  [%expect "(<= (+ 1 (* (- 1) x)) 0)"]
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
