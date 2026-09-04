[@@@warning "+unused-value-declaration"]

let trace_log fmt = Debug.trace "simpl" fmt

module NfaS = Nfa.String
module Set = Base.Set.Poly

let ( -- ) i j =
  let rec aux n acc = if n < i then acc else aux (n - 1) (n :: acc) in
  aux j []
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
  val unsupp : string -> Smtml.Expr.t -> ph

  val unsupp_check
    :  (Model.t
        -> Ast.t
        -> (string, Nfa.String.t) Base.Map.Poly.t
        -> (Ast.t -> [ `Sat of unit -> Model.t | `Unknown ])
        -> [ `Sat of unit -> Model.t | `Unknown ])
    -> ph

  val pow_minus_one : term -> term
end

module type SYM = sig
  include SYM0

  type repr

  val prj : ph -> repr [@@warning "-32"]
  val pp_str : Format.formatter -> term -> unit
  val const : int -> term
  val in_rei : term -> char list Regex.t -> ph
  val in_re_raw : str -> Nfa.String.t -> ph
  val in_re_rawi : term -> Nfa.String.t -> ph
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
    Ast.Eia.pow (Ast.Eia.const (Z.of_int !Config.base)) (Ast.Eia.atom (Ast.var c I))
  ;;

  let unsupp s e = Ast.Unsupp (`Msg (s, e))
  let unsupp_check c = Ast.Unsupp (`Check c)
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
    | Pow (Const base, Atom (Ast.Var (x, I))) when base = Z.of_int !Config.base ->
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
  type names = string Set.t

  type t =
    { exp : names
    ; all : names
    ; str : names
    }

  let is_in_expo name { exp; _ } = Set.mem exp name
  let is_in_string name { str; _ } = Set.mem str name

  let make ~exp ~all ~str =
    (* TODO: check subsumtion *)
    let of_list = Set.of_list in
    { exp = of_list exp; all = of_list all; str = of_list str }
  ;;

  let empty = make ~exp:[] ~all:[] ~str:[]

  let pp_exp ppf { exp; _ } =
    Format.fprintf
      ppf
      "exp: @[%a@]"
      Format.(
        pp_print_list Format.pp_print_string ~pp_sep:(fun ppf () -> fprintf ppf "@ "))
      (Set.to_list exp)
  [@@ocaml.warning "-unused-value-declaration"]
  ;;

  let pp_hum ppf { exp; all; str } =
    let open Format in
    let pp_list =
      pp_print_list Format.pp_print_string ~pp_sep:(fun ppf () -> fprintf ppf "@ ")
    in
    fprintf ppf "@[<v>";
    fprintf ppf "@[Exp: @[%a@]@]@," pp_list (Set.to_list exp);
    fprintf ppf "@[Str: @[%a@]@]@," pp_list (Set.to_list str);
    fprintf ppf "@[ALL: @[%a@]@]" pp_list (Set.to_list all);
    fprintf ppf "@]"
  ;;

  let union e1 e2 =
    let ( ++ ) = Set.union in
    { exp = e1.exp ++ e2.exp; all = e1.all ++ e2.all; str = e1.str ++ e2.str }
  ;;
end

module Who_in_exponents_ = struct
  module S = Set

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
      (Set.to_list all)
      pp_set
      (Set.to_list exp)
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
  let unsupp _ _ = empty
  let unsupp_check _ = empty
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

let apply_symantics (type a) (module S : SYM_SUGAR with type ph = a) ast =
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
    | Unsupp (`Msg (s, e)) -> S.unsupp s e
    | Unsupp (`Check c) -> S.unsupp_check c
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
  helper ast
;;

let apply_symantics_unsugared (type a) (module S : SYM with type ph = a) =
  let module M = struct
    include S
    include FT_SIG.Sugar (S)
  end
  in
  apply_symantics (module M)
;;

let make_main_symantics ?alpha ?agressive ?(with_nielsen = false) env =
  let _ : Env.t = env in
  let module Set = Set in
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
        (* trace_log "Substuting %s ~~> %a" s Ast.pp_term_smtlib2 c; *)
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
        Id_symantics.constz Z.(pow (Z.of_int !Config.base) (String.length s) - one)
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
      | Str_const s ->
        begin match s with
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
      | Ast.Eia.Str_const s, Ast.Eia.Const m, Ast.Eia.Const n ->
        let slen = Z.of_int (String.length s) in
        if Z.(lt m zero) || Z.(leq n zero) || Z.(geq m slen)
        then Ast.Eia.Str_const ""
        else (
          let m = Z.to_int m in
          let n = Z.to_int Z.(min n (slen - of_int m)) in
          Ast.Eia.Str_const (String.sub s m n))
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
        when Z.(equal c (Z.of_int !Config.base))
             && base_ = Z.of_int !Config.base
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
        Id_symantics.in_re_raw v (re |> Nfa.String.invert ?alpha)
      | Ast.Eia (Ast.Eia.InReRaw (v, I, re)) when Option.is_some alpha ->
        Id_symantics.in_re_rawi v (re |> Nfa.String.invert ?alpha)
      (* TODO: this is a dishonest invert here. It actually uses 0-9$ as an alphabet. *)
      | Ast.Eia (Ast.Eia.InRe (v, kind, re)) when Option.is_some alpha ->
        Ast.eia
          (Ast.Eia.inreraw v kind (Nfa.String.invert ?alpha (Nfa.String.of_regex re)))
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
        | _ -> Stdlib.compare l r
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
      (* [None] for a term [check_card] has no character count for (e.g. [Sofi]).
         Returning [[]] instead would make [check_card] count it as contributing
         zero characters and conclude [false_] for a satisfiable equation. *)
      let as_list : string Ast.Eia.term -> string Ast.Eia.term list option = function
        | Str_const _ as c -> Some [ c ]
        | Atom (Var _) as v -> Some [ v ]
        | Concat list -> Some list
        | (Substr _ | At _) as v -> Some [ v ]
        | _ -> None
      in
      let check_card lhs rhs =
        match as_list lhs, as_list rhs with
        | Some lhs, Some rhs -> check_card lhs rhs
        | _ -> false
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
      let if_with_nielsen res =
        if with_nielsen then res else Id_symantics.eq_str lhs rhs
      in
      match lhs, rhs with
      | Sofi (Atom (Var _) as l), Sofi (Atom (Var _) as r) -> Eia (Eq (l, r, I))
      | Str_const c1, Str_const c2 -> if String.equal c1 c2 then Ast.true_ else Ast.false_
      (* | (v, Ast.Eia.Str_const c | Ast.Eia.Str_const c, v)
        when Option.is_some alpha ->
          Id_symantics.in_re_raw v (Regex.str_to_re c |> NfaS.of_regex) *)
      | lhs, rhs when Eia.eq_term lhs rhs -> Ast.true_
      | lhs, rhs when check_card lhs rhs -> Ast.false_
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
         | _ -> if_with_nielsen (nielsen llhs [ rhs ]))
      | Str_const _, Concat lrhs ->
        (match lrhs with
         | Str_const _ :: _ -> trim [ lhs ] lrhs
         | _ -> if_with_nielsen (nielsen [ lhs ] lrhs))
      | Concat llhs, Concat lrhs -> if_with_nielsen (nielsen llhs lrhs)
      | _ -> Id_symantics.eq_str lhs rhs
    ;;

    let neq_str l r =
      let trim = trim Neq in
      match l, r with
      | Ast.Eia.Str_const l, Ast.Eia.Str_const r ->
        if l <> r then Ast.true_ else Ast.false_
      (* [v <> ""] is exactly [1 <= |v|]. Saying it with a length constraint
         instead of a complement automaton keeps the encoding independent of
         [alpha] and avoids determinizing over the whole alphabet: this is by
         far the most frequent disequality, because it is what the [str.at] /
         [str.substr] lowering emits for its out-of-range branch. *)
      | v, Ast.Eia.Str_const "" | Ast.Eia.Str_const "", v ->
        Id_symantics.leq (Ast.Eia.const Z.one) (Ast.Eia.len v)
      | (v, Ast.Eia.Str_const c | Ast.Eia.Str_const c, v) when Option.is_some alpha ->
        Id_symantics.in_re_raw
          v
          (Regex.str_to_re c |> Nfa.String.of_regex |> Nfa.String.invert ?alpha)
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
        max Z.one (gcd Z.zero atoms)
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
      | _ -> relop Eq l r
    ;;

    (* [str.len s] is never negative Length 0 -> empty string *)
    let by_len_nonneg l r =
      let open Ast.Eia in
      let summands =
        match add [ l; mul [ const Z.minus_one; r ] ] with
        | Add xs -> xs
        | x -> [ x ]
      in
      let nonpositive = function
        | Const c -> Z.leq c Z.zero
        | Mul [ Const c; Len _ ] -> Z.lt c Z.zero
        | _ -> false
      in
      let is_empty s = Option.some (Ast.eia (eq s (Str_const "") Ast.S)) in
      if List.for_all nonpositive summands
      then Option.some Ast.true_
      else (
        match summands with
        | [ Len s ] -> is_empty s
        | [ Mul [ Const c; Len s ] ] when Z.gt c Z.zero -> is_empty s
        | _ -> Option.none)
    ;;

    let leq l r =
      let open Ast.Eia in
      match by_len_nonneg l r with
      | Some ph -> ph
      | None ->
        begin match l, r with
        | Add lhs, Add rhs -> cancel_left (relop Leq) lhs rhs
        | lhs, Add rhs -> cancel_left (relop Leq) [ lhs ] rhs
        | Add lhs, rhs -> cancel_left (relop Leq) lhs [ rhs ]
        | _ -> relop Leq l r
        end
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
      let re = Regex.concat re (Regex.kleene (Regex.Symbol [ Nfa.Str10.u_zero ])) in
      Nfa.String.of_regex re
    ;;

    let in_re s re =
      match s with
      | Ast.Eia.Atom (Ast.Var (s, S)) ->
        begin match Env.lookup_string s env with
        | Some (Ast.Eia.Str_const _ as c) -> Ast.eia (Eia.inre c Ast.S re)
        | Some (Ast.Eia.Const c) ->
          begin match
            Nfa.String.of_regex re
            |> Nfa.String.intersect (from_eia_nfa c)
            |> Nfa.String.run (*(String.to_seq str |> List.of_seq |> List.rev)*)
          with
          | true -> Ast.true_
          | false -> Ast.false_
          end
        | None | _ -> Ast.eia (Eia.inre (Eia.Atom (Ast.Var (s, S))) Ast.S re)
        end
      | Ast.Eia.Sofi (Const c) ->
        (* v = sofi 4 <=> v="4" | v="04" | v="004" | ... *)
        begin match
          Nfa.String.of_regex re
          |> Nfa.String.intersect (from_eia_nfa c)
          |> Nfa.String.run (*(String.to_seq str |> List.of_seq |> List.rev)*)
        with
        | true -> Ast.true_
        | false -> Ast.false_
        end
      | Ast.Eia.(Str_const str) ->
        begin match
          Nfa.String.of_regex re
          |> Nfa.String.re_accepts (String.to_seq str |> List.of_seq |> List.rev)
        with
        | true -> Ast.true_
        | false -> Ast.false_
        end
      | _ -> Id_symantics.in_re s re
    ;;

    let in_rei s re =
      match s with
      | Ast.Eia.(Const c) ->
        begin match
          Nfa.String.of_regex re
          |> Nfa.String.intersect (from_eia_nfa c)
          |> Nfa.String.run
        with
        | true -> Ast.true_
        | false -> Ast.false_
        end
      | _ -> Id_symantics.in_rei s re
    ;;

    let in_re_raw s re =
      match s with
      | Ast.Eia.(Str_const str) ->
        begin match
          Regex.str_to_re str
          |> Nfa.String.of_regex
          |> Nfa.String.intersect re
          |> Nfa.String.run
        with
        | true -> Ast.true_
        | false -> Ast.false_
        end
      | _ -> Id_symantics.in_re_raw s re
    ;;

    let in_re_rawi s re =
      match s with
      | Ast.Eia.(Const c) ->
        begin match re |> Nfa.String.intersect (from_eia_nfa c) |> Nfa.String.run with
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

let subst env ast =
  let (module S : SYM_SUGAR_AST) = make_main_symantics ~agressive:true env in
  let rec loop ast =
    let ast2 = apply_symantics_unsugared (module S) ast in
    if Ast.equal ast ast2 then ast else loop ast2
  in
  loop ast
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
          (<= (+ (- 52) (exp 10 x) (exp 10 y)) 0)
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
          (<= (+ (- 13) (* 5 x)) 0)
          (<= (+ (- 52) x z) 0)
          (<= (+ 13 (* (- 5) x) (* (- 7) z) (* (- 8) (exp 2 y))) 0))

        Exp: y
        Str:
        ALL: x y z
        |}]
    ;;
  end)
;;

module ZTM = Map.Make (struct
    type t = Z.t Ast.Eia.term

    let compare = Stdlib.compare
  end)

let propagate_exponents ast =
  assert (Ast.is_conjunct ast);
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

let find_vars_for_under2s ast =
  let module S = Set in
  let open Ast.Eia in
  let fz = fun acc _ -> acc in
  let fs : bool -> string S.t -> string Ast.Eia.term -> _ =
    let reverse_if = fun x -> if x then List.rev else Fun.id in
    let remove_head = function
      | Atom (Var (_, S)) :: xs -> xs
      | Const _ :: Atom (Var (_, S)) :: xs -> xs
      | _ -> []
    in
    fun is_left acc -> function
      | Concat xs when Ast.Eia.is_concat_nontrivial xs ->
        let xs = xs |> reverse_if is_left |> remove_head in
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
  collect (fs true) ast, collect (fs false) ast
;;

let shrink_variables ast =
  let module Set = Set in
  let _ : Ast.t = ast in
  (* trace_log "old ast: @[%a@]\n" Ast.pp_smtlib2 ast; *)
  let info = apply_symantics (module Who_in_exponents) ast in
  (* trace_log "@[<v 2>@[Old info:@]@ @[%a@]@]\n" Info.pp_hum info; *)
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
    let good_enough_constant rhs =
      Z.(lt zero rhs) && Z.lt rhs (Z.of_int (Config.huge_const ()))
    ;;

    let leq l r =
      let base = constz (Z.of_int !Config.base) in
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
    trace_log "Post-simplification: @[%a@]\n" Ast.pp_smtlib2 ast2;
    let info2 = apply_symantics (module Who_in_exponents) ast in
    trace_log "@[<v 2>@[New info:@]@ @[%a@]@]\n" Info.pp_hum info2;
    ast2)
  else ast
;;

(* [str.len s] is never negative, which decides some inequalities outright and
   turns others into a much more useful equality. See [by_len_nonneg]. *)
let%expect_test "length non-negativity in inequalities" =
  let (module TS : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  let show ph = Format.printf "@[%a@]\n%!" Ast.pp_smtlib2 ph in
  let len s = TS.str_len (TS.str_var s) in
  let open TS in
  (* Tautologies: every summand on the left is non-positive. *)
  show (mul [ const (-1); len "s" ] <= const 0);
  [%expect "True"];
  show
    (add [ const (-5); mul [ const (-2); len "s" ]; mul [ const (-1); len "t" ] ]
     <= const 0);
  [%expect "True"];
  (* A non-positive length squeezes the string to be empty. *)
  show (len "s" <= const 0);
  [%expect "(= s \"\")"];
  show (mul [ const 3; len "s" ] <= const 0);
  [%expect "(= s \"\")"];
  (* Neither rule applies: the length may well be positive here. *)
  show (len "s" <= const 5);
  [%expect "(<= (+ (- 5) (str.len s)) 0)"];
  show (add [ len "s"; mul [ const (-1); len "t" ] ] <= const 0);
  [%expect "(<= (+ (str.len s) (* (- 1) (str.len t))) 0)"];
  ()
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
          (<= (+ (- 52) (exp 10 x) (exp 10 y)) 0)
          (<= (+ (- 3) x) 0))

        (and
          (<= (+ (- 52) (exp 10 x) (exp 10 y)) 0)
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
          (<= (+ (- 5000) (exp 10 u) (exp 10 v) (exp 10 x) (exp 10 y)) 0)
          (<= (+ x (* (- 1) y)) 0)
          (<= (+ (* (- 1) u) v) 0))

        (and
          (<= (+ (- 5000) (exp 10 u) (exp 10 v) (exp 10 x) (exp 10 y)) 0)
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
          (<= (+ (- 52) (exp 10 x) (exp 10 y)) 0)
          (<= (+ x (* (- 3) y)) 0))

        (and
          (<= (+ (- 52) (exp 10 x) (exp 10 y)) 0)
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
    if Set.mem all ans then gensym height else ans
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
      | None -> Smtml.Expr.symbol (Smtml.Symbol.make_var Smtml.Ty.Ty_int s)
      | Some c -> constz c
    ;;

    let str_concat _ = failwith "not implemented str_concat"
    let str_at _ = failwith "not implemented str_at"
    let str_substr _ = failwith "not implemented str_substr"
    let str_prefixof _ = failwith "not implemented str_prefixof"
    let str_contains _ = failwith "not implemented str_contains"
    let str_suffixof _ = failwith "not implemented str_suffixof"

    (*let pow2var s = pow (const Z.(Z.of_int !Config.base |> to_int)) (var s)*)
    let pow_minus_one t = pow (constz Z.minus_one) t
    let exists vars x = failwith "tbd"
    let pow2var s = pow (constz (Z.of_int !Config.base)) (var s)
    let str_len2 _ = failwith "not implemented str_len2"
    let pp_str = Smtml.Expr.pp
    let const c = constz (Z.of_int c)
    let in_rei _ = failwith "not implemented in_rei"
    let in_re_raw _ = failwith "not implemented in_re_raw"
    let in_re_rawi _ = failwith "not implemented in_re_rawi"
    let rlen _ = failwith "not implemented rlen"
    let unsupp _ = failwith "not implemented unsupp"
    let unsupp_check _ = failwith "not implemented unsupp check"
  end
  in
  (module struct
    include M
    include FT_SIG.Sugar (M)
  end : SYM_SUGAR
    with type ph = Smtml.Expr.t)
;;

(* What we decided to do with a single equality.

   [Prop] records the substitution in the environment and leaves the formula as
   it is: the driver loop in [basic_simplify] applies the environment to the
   whole formula on its next iteration. Sound only where the equality is asserted
   unconditionally, i.e. somewhere in a top-level conjunction.

   [PropAndPreserve] rewrites the formula in place *and* re-asserts the equality
   as a conjunct. This is the variant to use below a disjunction: a branch must
   not drop the equality it propagates, and its environment cannot escape to the
   sibling branches. Unlike [Prop] it can substitute an arbitrary term, not just
   a variable.

   [PropLen] records that a string variable has a known length, which lets
   regular-membership constraints on it be unfolded into a disjunction of words. *)
type action =
  | Prop : string * Ast.typed_term -> action
  | PropAndPreserve : 'a Ast.Eia.term * 'a Ast.Eia.term * 'a Ast.kind -> action
  | PropLen : string * Z.t -> action
  | Noprop

(* A term is substitutable only when it is free of [str.at]/[str.substr]: those
   are lowered into fresh variables later on, and duplicating them across the
   formula loses the sharing that the lowering relies on. *)
let is_substitutable eia =
  let open Ast.Eia in
  fold_term
    (fun acc el ->
       match el with
       | At _ | Substr _ -> false
       | _ -> acc)
    (fun acc el ->
       match el with
       | At _ | Substr _ -> false
       | _ -> acc)
    true
    eia
;;

(* Variables pinned between a constant lower *and* a constant upper bound —
   typically the remainder that lowering [mod] introduces, with 0 <= %r < c.
   Substituting a multi-variable term for one of these loses the bounds, so
   [breaks_range] below refuses to do it. *)
let ranged_vars_of ast =
  let open Ast in
  let open Ast.Eia in
  let rec coeff_sign vn = function
    | Atom (Var (s, _)) -> if s = vn then 1 else 0
    | Const _ -> 0
    | Add ts ->
      List.fold_left
        (fun acc t ->
           match acc, coeff_sign vn t with
           | a, 0 -> a
           | 0, b -> b
           | a, b when a = b -> a
           | _ -> 0)
        0
        ts
    | Mul ts ->
      (match List.filter (fun t -> Set.mem (collect_vars t) vn) ts with
       | [ Atom (Var (s, _)) ] when s = vn ->
         List.fold_left
           (fun acc -> function
              | Const c -> acc * Z.sign c
              | _ -> acc)
           1
           ts
       | _ -> 0)
    | t -> 0
  in
  collect_atomic ast
  |> List.fold_left
       (fun acc -> function
          | Eia (Leq (lhs, Const _)) ->
            let vs = collect_vars lhs in
            if Set.length vs = 1
            then (
              let vn = Set.choose_exn vs in
              match coeff_sign vn lhs with
              | s when s <> 0 ->
                let lo, hi = Option.value ~default:(false, false) (Map.find acc vn) in
                Map.set acc ~key:vn ~data:(if s > 0 then lo, true else true, hi)
              | _ -> acc)
            else acc
          | _ -> acc)
       Map.empty
  |> Map.filter ~f:(fun (lo, hi) -> lo && hi)
  |> Map.keys
;;

(* Knowing that [s] has length exactly [len], replace every regular-membership
   constraint on [s] by the disjunction of the words of that length it accepts.

   NOTE: [unfold_nfa_with_fixed_len] is still a stub returning [None], so this
   whole rewriting is currently a no-op and [PropLen] has no observable effect.
   The scaffolding around it is kept for whoever implements the unfolding. *)
let unfold_regexes_at_fixed_len s len ast =
  let open Ast in
  let many_words = 10 in
  let unfold_nfa_with_fixed_len _len _nfa = None in
  let words_into_disjunction ?default words =
    if Option.is_some default && List.length words > many_words
    then default |> Option.get
    else
      words
      |> List.map (fun word -> Eia.eq (Eia.Atom (Var (s, S))) (Eia.Str_const word) S)
      |> List.map Ast.eia
      |> Ast.lor_
  in
  let unfold nfa orig =
    unfold_nfa_with_fixed_len len nfa
    |> Option.map words_into_disjunction
    |> Option.value ~default:orig
  in
  Ast.map
    (function
      | Eia (Eia.InRe (Eia.Atom (Var (s', S)), S, re)) as orig when s = s' ->
        unfold (NfaS.of_regex re) orig
      | Eia (Eia.InReRaw (Eia.Atom (Var (s', S)), S, nfa)) as orig when s = s' ->
        unfold nfa orig
      | Eia (Eia.InRe (Eia.Atom (Var (s', I)), I, re)) as orig when s = s' ->
        unfold (NfaS.of_regex re) orig
      | Eia (Eia.InReRaw (Eia.Atom (Var (s', I)), I, nfa)) as orig when s = s' ->
        unfold nfa orig
      | el -> el)
    ast
;;

(* Carry out a single [action], returning the (possibly extended) environment and
   the (possibly rewritten) formula. See [action] for why some variants touch the
   environment and others rewrite the formula. *)
let apply_action =
  let (module S : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  let trivial_simplify eta = subst_term Env.empty eta in
  let map_eia f ast =
    Ast.map
      (function
        | Ast.Eia eia -> Ast.eia (f eia)
        | el -> el)
      ast
  in
  fun env ast -> function
    | Noprop -> env, ast
    (* Environment only: the formula is left as it is and the driver loop applies
       the substitution globally on its next pass. *)
    | Prop (vn, Ast.TT (Ast.I, term)) ->
      let term = trivial_simplify term in
      ( (try Env.extend_int_exn env vn term with
         | Env.Occurs -> env)
      , ast )
    | Prop (vn, Ast.TT (Ast.S, term)) ->
      let term = trivial_simplify term in
      ( (try Env.extend_string_exn env vn term with
         | Env.Occurs -> env)
      , ast )
    (* In place: substitute throughout, and re-assert the equality so that the
       rewriting stays equivalence-preserving even under a disjunction. *)
    | PropAndPreserve (term, rhs, Ast.I) ->
      let ast =
        map_eia
          (Ast.Eia.map2 Fun.id (fun term' -> if term = term' then rhs else term') Fun.id)
          ast
      in
      env, Ast.land_ [ S.eqz term rhs; ast ]
    | PropAndPreserve (term, rhs, Ast.S) ->
      let ast =
        map_eia
          (Ast.Eia.map2 Fun.id Fun.id (fun term' -> if term = term' then rhs else term'))
          ast
      in
      env, Ast.land_ [ S.eq_str term rhs; ast ]
    | PropLen (s, len) -> env, unfold_regexes_at_fixed_len s len ast
;;

let select_actions classify conjuncts =
  let is_prop = function
    | Prop _ -> true
    | _ -> false
  in
  let independent_of vn chosen =
    List.for_all
      (function
        | Prop (vn', Ast.TT (Ast.I, rhs)) ->
          vn <> vn' && not (Set.mem (Ast.Eia.collect_vars rhs) vn)
        | Prop (vn', Ast.TT (Ast.S, rhs)) ->
          vn <> vn' && not (Set.mem (Ast.Eia.collect_vars rhs) vn)
        | _ -> true)
      chosen
  in
  List.fold_left
    (fun chosen conjunct ->
       match classify conjunct with
       | Noprop -> chosen
       | Prop (vn, _) as action when independent_of vn chosen ->
         action :: List.filter is_prop chosen
       | (PropAndPreserve _ | PropLen _) as action when not (List.exists is_prop chosen)
         -> action :: chosen
       | _ -> chosen)
    []
    conjuncts
;;

let rec eq_propagation (info : Info.t) ?soft ?multiple:bool (env : Env.t) (ast : Ast.t) =
  let open Ast in
  let open Ast.Eia in
  let (module S : SYM_SUGAR_AST) = make_main_symantics Env.empty in
  let handle_action = apply_action in
  let noprop = Noprop in
  let is_simpl = is_substitutable in
  let ranged_vars = ranged_vars_of ast in
  let breaks_range vn rhs =
    Set.length (collect_vars rhs) > 1 && List.mem vn ranged_vars
  in
  let returni vn rhs =
    if is_simpl rhs && not (breaks_range vn rhs)
    then
      if Option.value ~default:false soft
      then PropAndPreserve (Atom (var vn I), rhs, I)
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
  (* [len_term], a [str.len] application on [vn], is known to equal [n].

     Below a disjunction we substitute the constant for it in place, keeping the
     equality: that is what carries a length equality from an enclosing
     conjunction down into a nested disjunction, and a disjunct has no
     environment of its own to record it in. At the top level we keep returning
     [PropLen], whose intent is to unfold regular constraints on [vn] into the
     words of that length. *)
  let known_length len_term vn n =
    if Option.value ~default:false soft
    then PropAndPreserve (len_term, Ast.Eia.Const n, Ast.I)
    else PropLen (vn, n)
  in
  let trivial_string_propagations v = function
    | rhs -> returns v rhs
  in
  let term_propagations lhs =
    let cnt lhs =
      Ast.fold
        (fun acc -> function
           | Eia eia ->
             fold2
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
  (* Decide what, if anything, a single (in)equality lets us propagate. The
     cases are tried from the cheapest and most obviously safe to the most
     speculative: [trivial_*] handles [x = c] and [x = y], [advanced_*] solves a
     linear equation for one of its variables, [term_propagations] substitutes a
     repeated compound term, and [last_resort] picks a variable out of a sum. *)
  let classify_equality info orig_ast env ast =
    let var_can_be_prop ?rhs v =
      Env.is_absent_key v env
      && Option.value
           ~default:true
           (Option.map (fun rhs -> Env.occurs_var env v rhs |> not) rhs)
    in
    let var_can_subst_complex v = var_can_be_prop v && not (Ast.in_strlen v ast) in
    let trivial_integer_propagations vn rhs =
      match rhs with
      | Ast.Eia.Const _
      | Iofs (Atom (Var _))
      | Len (Atom (Var _))
      | Len2 (Atom (Var _))
      | Sofi (Atom (Var _)) -> returni vn rhs
      | Atom (Ast.Var (vn', I)) when vn' <> vn ->
        if var_can_subst_complex vn
        then returni vn rhs
        else if
          var_can_subst_complex vn' && not (Env.occurs_var env vn' (Atom (var vn I)))
        then returni vn' (Atom (var vn I))
        else noprop
      | _ -> noprop
    in
    let advanced_integer_propagations (lhs : Z.t term) (rhs : Z.t term) : action =
      let (module S : SYM_SUGAR_AST) = make_main_symantics Env.empty in
      let single =
        fun c1 (Var (vn1, _) as v1) c2 (Var (vn2, _) as v2) rhs ->
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
      | Atom (Var (vn, I)), Mul [ Const cl; Atom (Var (vn2, I)) ]
        when vn = vn2 && var_can_be_prop vn ->
        (* (= ( * c v) vr) *)
        returni vn (Const Z.zero)
      | Mul [ Const cl; Atom (Var (vn, I)) ], Mul [ Const cl2; Atom (Var (vn2, I)) ]
        when vn = vn2 && cl <> cl2 && var_can_be_prop vn -> returni vn (Const Z.zero)
      | Ast.Eia.Mul [ Const _; Atom (Var (vn, _)) ], (Const z as rhs)
        when Z.(equal z zero) && var_can_be_prop vn ->
        (* (= ( * c v) 0) *)
        returni vn rhs
      | Mul [ Const cl; Atom (Var (vn, _)) ], Const cr
        when Z.(cr mod cl = zero) && var_can_be_prop vn ->
        let rhs = Ast.Eia.(Const Z.(cr / cl)) in
        returni vn rhs
      | ( Add [ Atom (Var (v1n, _)); Mul [ Const c; (Atom (Var (v2n, _)) as v2) ] ]
        , Const z0 )
        when Z.(equal z0 zero) && var_can_be_prop v1n ->
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
        (* trace_log "%s %d. ast = %a" __FILE__ __LINE__ Ast.pp_smtlib2 ast; *)
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
        when Z.(cr = zero) && Z.(cl <> zero) && var_can_be_prop vn ->
        returns vn (S.str_const "")
      | Len (Atom (Var (vn, _))), Const cr when Z.(cr = zero) && var_can_be_prop vn ->
        returns vn (S.str_const "")
      | _ -> noprop
    in
    let last_resort lhs rhs =
      match lhs, rhs with
      | Add xs, Const z
        when z = Z.zero
             && List.exists
                  (function
                    | Atom (Var (x, _)) -> var_can_be_prop x
                    | _ -> false)
                  xs ->
        let filtered = ref false in
        let vn = ref Option.none in
        let xs =
          List.filter
            (function
              | Atom (Var (vn', _)) when (not !filtered) && var_can_be_prop vn' ->
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
          || (List.mem vn (Ast.get_exp_vars orig_ast) && not (Ast.Eia.is_simple rhs))
          || not (var_can_be_prop vn)
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
          || (List.mem vn (Ast.get_exp_vars orig_ast) && not (Ast.Eia.is_simple rhs))
        then noprop
        else returni vn rhs
      (* [c + str.len s = 0] and [c - str.len s = 0]: the length of [s] is known. *)
      | ( Ast.Eia.Add [ Ast.Eia.Const c; (Ast.Eia.Len (Ast.Eia.Atom (Var (vn', _))) as l) ]
        , Ast.Eia.Const rhs )
        when rhs = Z.zero -> known_length l vn' Z.(neg c)
      | ( Ast.Eia.Add
            [ Ast.Eia.Const c
            ; Ast.Eia.Mul
                [ Ast.Eia.Const d; (Ast.Eia.Len (Ast.Eia.Atom (Var (vn', _))) as l) ]
            ]
        , Ast.Eia.Const rhs )
        when rhs = Z.zero && d = Z.minus_one -> known_length l vn' c
      | _ -> noprop
    in
    let commut f lhs rhs =
      match f lhs rhs with
      | Noprop -> f rhs lhs
      | smth -> smth
    in
    let module Set = Set in
    match ast with
    | Eia (Eia.Eq ((Eia.Atom (Var (vn, I)) as lhs), rhs, I)) when var_can_be_prop vn ~rhs
      ->
      begin match trivial_integer_propagations vn rhs with
      | Noprop -> begin advanced_integer_propagations lhs rhs end
      | smth -> smth
      end
    | Eia (Eia.Eq (rhs, Eia.Atom (Var (vn, I)), I)) when var_can_be_prop ~rhs vn ->
      trivial_integer_propagations vn rhs
    | Eia (Eia.Eq (Eia.Atom (Var (vn, S)), rhs, S)) when var_can_be_prop ~rhs vn ->
      trivial_string_propagations vn rhs
    | Eia (Eia.Eq (rhs, Eia.Atom (Var (vn, S)), S)) when var_can_be_prop ~rhs vn ->
      trivial_string_propagations vn rhs
    | Eia (Eia.Eq (lhs, rhs, I)) ->
      begin match commut advanced_integer_propagations lhs rhs with
      | Noprop ->
        begin match commut term_propagations lhs rhs with
        | Noprop -> last_resort lhs rhs
        | smth -> smth
        end
      | smth -> smth
      end
    | eq -> noprop
  in
  (* Recurse into the branches of a disjunction. [env] must be threaded in
     explicitly: the equalities learned from the enclosing conjunction have to be
     visible here, otherwise [(x = a) /\ (ph(x) \/ psi)] never rewrites [ph(x)].
     Inside a disjunct we always go [~soft:true], since a disjunct may not drop
     the equality it propagates. *)
  let propagate env =
    List.map (fun y ->
      let env, ph = eq_propagation ~soft:true info env y in
      let (module Symantics) = make_main_symantics env in
      apply_symantics_unsugared (module Symantics) ph)
  in
  match ast with
  | Land xs ->
    (* Every conjunct holds, so each equality among them may be propagated to all
       the others. *)
    let actions = select_actions (classify_equality info ast env) xs in
    let env, ph =
      List.fold_left (fun (env, ph) -> handle_action env ph) (env, ast) actions
    in
    (* ...including down into the nested disjunctions, which is what makes
       [(x = a) /\ (ph(x) \/ psi)] reduce to [(x = a) /\ (ph(a) \/ psi)]. *)
    let ph =
      match ph with
      | Land xs ->
        land_
          (List.map
             (function
               | Lor ys -> lor_ (propagate env ys)
               | el -> el)
             xs)
      | ph -> ph
    in
    env, ph
  | Lor ys -> env, lor_ (propagate env ys)
  | Eia _ -> handle_action env ast (classify_equality info ast env ast)
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

(* Issue #258: an equality asserted in a conjunction must reach *every* nested
   Boolean combination below it: [(x = a) /\ ph(x)] ~> [(x = a) /\ ph(a)]. *)
let%expect_test "eq_propagation into boolean combinations" =
  let open Ast in
  let sv s = Ast.Eia.Atom (Ast.var s Ast.S) in
  let len s = Ast.Eia.len (sv s) in
  let ( =. ) lhs rhs = Ast.eia (Ast.Eia.eq lhs rhs Ast.I) in
  let ( <=. ) lhs rhs = Ast.eia (Ast.Eia.leq lhs rhs) in
  (* One [eq_propagation] pass only propagates what is visible at the time it
     runs, and a substitution can expose further ones (expanding [s13] here
     creates new [str.len s17] occurrences). So iterate to a fixed point, the way
     the driver loop in [basic_simplify] does. *)
  let test ~all ph =
    let info = Info.make ~all ~exp:[] ~str:all in
    let rec fixpoint budget env ph =
      let env, ph' = eq_propagation info env ph in
      let (module Symantics) = make_main_symantics env in
      let ph' = apply_symantics_unsugared (module Symantics) ph' in
      if budget = 0 || Ast.equal ph ph' then ph' else fixpoint (budget - 1) env ph'
    in
    Format.printf "@[%a@]\n%!" Ast.pp_smtlib2 (fixpoint 10 Env.empty ph)
  in
  (* The shape reported in the issue, cut down to the essentials: two equalities
     at the outer [and], both of which should fire inside the nested [or]. *)
  test
    ~all:[ "s13"; "s17"; "s18"; "s20"; "s6" ]
    (land_
       [ Ast.eia
           (Ast.Eia.eq (sv "s13") (Ast.Eia.concat [ sv "s17"; sv "s20"; sv "s18" ]) S)
       ; len "s17" =. Ast.Eia.Const Z.one
       ; lor_
           [ Ast.Eia.add [ len "s20"; Ast.Eia.Const Z.one ] =. len "s6"
           ; land_
               [ Ast.Eia.add [ Ast.Eia.Const Z.one; len "s20" ] =. len "s13"
               ; len "s13" <=. len "s6"
               ]
           ]
       ]);
  [%expect
    " \n\
    \ (and\n\
    \   (= (+ (- 1) (str.len s17)) 0)\n\
    \   (or\n\
    \     (= (+ 1 (str.len s20) (* (- 1) (str.len s6))) 0)\n\
    \     (and\n\
    \       (= (+ 1 (* (- 1) (str.len s17)) (* (- 1) (str.len s18))) 0)\n\
    \       (<= (+ (str.len s17) (str.len s18) (str.len s20)\n\
    \           (* (- 1) (str.len s6))) 0))))\n\
    \ "];
  (* Same equalities, but one level deeper: this is the nesting actually reported
     in the issue, where the [and] carrying the equalities is itself a disjunct,
     so the propagation has to run in [~soft:true] mode. *)
  test
    ~all:[ "s13"; "s17"; "s18"; "s20"; "s6" ]
    (lor_
       [ land_
           [ Ast.eia
               (Ast.Eia.eq (sv "s13") (Ast.Eia.concat [ sv "s17"; sv "s20"; sv "s18" ]) S)
           ; len "s17" =. Ast.Eia.Const Z.one
           ; lor_
               [ Ast.Eia.add [ len "s20"; Ast.Eia.Const Z.one ] =. len "s6"
               ; land_
                   [ Ast.Eia.add [ Ast.Eia.Const Z.one; len "s20" ] =. len "s13"
                   ; len "s13" <=. len "s6"
                   ]
               ]
           ]
       ; Ast.eia (Ast.Eia.eq (sv "s20") (Ast.Eia.Str_const "") S)
       ]);
  [%expect
    " \n\
    \ (or\n\
    \   (and\n\
    \     (= s13 (str.++ s17 s20 s18))\n\
    \     (= (+ (- 1) (str.len s17)) 0)\n\
    \     (or\n\
    \       (= (+ 1 (str.len s20) (* (- 1) (str.len s6))) 0)\n\
    \       (and\n\
    \         (= s18 \"\")\n\
    \         (<= (+ 1 (str.len s20) (* (- 1) (str.len s6))) 0))))\n\
    \   (= s20 \"\"))\n\
    \ "];
  ()
;;

exception Str_Underapprox_fired of Env.t

(* type step = int list *)
(* [[]] is the silent step used for internal reruns (e.g. unsat-core
   minimization); it stays [[]] so those reruns never log. *)
let next = function
  | [] -> []
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
      let zz = Ast.Eia.(Const z) in
      extend (leq (constz Z.zero) r);
      extend (lt r zz);
      if Config.config.mod_eq
      then
        (* [r = t (mod z)] said as the congruence shape [Me] reads into an
           [Ir.Div]: the remainder track stays range-bounded and no unbounded
           quotient track is spent. Under [-no-mod-eq] the [Div] machinery is
           off, so the classical [t = z*q + r] flattening remains. *)
        extend
          (eqz
             (Ast.Eia.mod_ (add [ t; mul [ constz Z.minus_one; r ] ]) z)
             (constz Z.zero))
      else (
        let q = var (gensym ~prefix:"%q" ()) in
        extend (eqz t (add [ mul [ zz; q ]; r ])));
      r
    ;;
  end
  in
  (* A top-level [t mod m = c] with [0 <= c < m] is left alone: [Me] turns it
     into an [Ir.Div] congruence, for which the NFA layer has a direct (small)
     automaton. Lowering it here would spend two fresh unbounded variables per
     occurrence -- which is exactly what quantifier elimination produces a lot
     of. Anything else, including a [mod] nested inside a term, still gets
     lowered the usual way -- as does everything, congruence or not, under
     [-no-mod-eq]. *)
  let rec has_mod : 'a. 'a Ast.Eia.term -> bool =
    fun (type a) (t : a Ast.Eia.term) : bool ->
    match t with
    | Ast.Eia.Mod _ -> true
    | Add xs | Mul xs -> List.exists has_mod xs
    | Pow (a, b) | Bwand (a, b) | Bwor (a, b) | Bwxor (a, b) -> has_mod a || has_mod b
    | _ -> false
  in
  let is_congruence ph =
    Config.config.mod_eq
    &&
      match ph with
      | Ast.Eia (Ast.Eia.Eq (Ast.Eia.Mod (t, m), Ast.Eia.Const c, Ast.I))
      | Ast.Eia (Ast.Eia.Eq (Ast.Eia.Const c, Ast.Eia.Mod (t, m), Ast.I)) ->
        Z.(geq c zero) && Z.(lt c (abs m)) && not (has_mod t)
      | _ -> false
  in
  let rec walk ph =
    if is_congruence ph
    then ph
    else (
      match ph with
      | Ast.Land xs -> Ast.land_ (List.map walk xs)
      | Ast.Lor xs -> Ast.lor_ (List.map walk xs)
      | Ast.Lnot x -> Ast.lnot (walk x)
      | Ast.Exists (vs, x) -> Ast.exists vs (walk x)
      | ph -> apply_symantics_unsugared (module M) ph)
  in
  let ph = walk ast in
  match !acc with
  | [] -> ph
  | acc -> Ast.land_ (ph :: acc)
;;

module Collect_alpha_ (*: SYM_SUGAR with type repr = char Set.t and type ph = char Set.t*) =
struct
  module S = Set

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
  let in_re_raw lhs re = lhs ++ Nfa.String.alpha re
  let in_re_rawi lhs re = lhs ++ Nfa.String.alpha re
  let str_len s = s
  let sofi s = s
  let iofs s = s
  let str_const s = String.to_seq s |> List.of_seq |> S.of_list

  let str_var v =
    (* Format.printf "%s %d: %s\n%!" __FUNCTION__ __LINE__ v; *)
    empty
  ;;

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
  let unsupp _ _ = empty
  let unsupp_check _ = empty
end

module Collect_alpha :
  SYM_SUGAR with type repr = Collect_alpha_.repr and type ph = Collect_alpha_.repr =
struct
  include Collect_alpha_
  include FT_SIG.Sugar (Collect_alpha_)
end

let collect_alpha ast = apply_symantics (module Collect_alpha) ast

(* Does the formula read some string as a number ([str.to_int]/[str.from_int])? *)
let reads_strings_as_numbers ast =
  Ast.fold
    (fun acc -> function
       | Ast.Eia eia ->
         Ast.Eia.fold2
           (fun acc -> function
              | Ast.Eia.Iofs _ -> true
              | _ -> acc)
           (fun acc -> function
              | Ast.Eia.Sofi _ -> true
              | _ -> acc)
           acc
           eia
       | _ -> acc)
    false
    ast
;;

(* [v <> c] and [not (v in re)] are lowered into a *complement* automaton built
   over [alpha] (see [neq_str] and [not] in [make_main_symantics]). Taking
   [alpha] to be "the characters of the input constants plus one fresh
   character" is the classical sufficient alphabet for pure word (dis)equations:
   one spare character is enough to satisfy any number of disequalities.

   That argument breaks as soon as the same variable is also read numerically.
   [str.to_int v] constrains the characters of [v] to be decimal digits (see
   [arithmetize]), so a complement taken over an alphabet that is missing a
   digit silently deletes satisfying assignments, and the solver reports [unsat]
   for a satisfiable formula. Concretely, on a formula whose only string
   constants are ["-"] and [""], [v <> ""] used to denote "digit strings ending
   in [0]", which made e.g.

     (assert (not (= s ""))) (assert (= (str.to_int s) 2))

   come out [unsat]. [under_str] already unions [Regex.dec] into its own
   alphabet for exactly this reason; the main path has to do the same. *)
let alpha_with_extra_char ast =
  let alpha = collect_alpha ast in
  let alpha =
    if reads_strings_as_numbers ast
    then Regex.dec |> String.to_seq |> Seq.fold_left Set.add alpha
    else alpha
  in
  Utils.with_extra_char alpha
;;

let rec basic_simplify
          step
          ?multiple
          ?(with_nielsen = false)
          ?(minimize = true)
          (env : Env.t)
          orig_ast
  =
  let trace_log =
    if step = [] then fun ppf -> Format.ifprintf Format.std_formatter ppf else trace_log
  in
  trace_log "iter(%a)= @[%a@]" pp_step step Ast.pp_smtlib2 orig_ast;
  (* Deletion-based core minimization: a literal is dropped iff the remaining
     conjunction still simplifies to a contradiction (relative to the initial
     [env]). Every deletion is verified by re-running the simplifier, so no
     justification can be lost the way the old reachability-based "short env"
     shortening used to lose cross-variable ones. Capped so a huge candidate
     core does not trigger a quadratic pile of simplifier reruns. *)
  let minimize_core literals =
    let still_unsat = function
      | [] -> false
      | lits ->
        (match
           basic_simplify [] ?multiple ~with_nielsen ~minimize:false env (Ast.land_ lits)
         with
         | `Unsat _ -> true
         | `Sat _ | `Unknown _ -> false)
    in
    List.fold_left
      (fun kept lit ->
         let rest = List.filter (fun l -> not (Ast.equal l lit)) kept in
         if List.compare_lengths rest kept < 0 && still_unsat rest then rest else kept)
      literals
      literals
  in
  let max_minimized_core_size = 64 in
  let alpha = alpha_with_extra_char orig_ast in
  trace_log
    "Alphabet with extra char: %a\n%!"
    Format.(pp_print_list ~pp_sep:(fun ppf () -> fprintf ppf " ") pp_print_char)
    alpha;
  let rec loop step (env : Env.t) ast =
    let (module Symantics) = make_main_symantics ~alpha ~with_nielsen env in
    let rez = apply_symantics (module Symantics) ast in
    let ast2 = Symantics.prj rez in
    let ast2 = if Ast.is_conjunct ast2 then propagate_exponents ast2 else ast2 in
    let __ _ = trace_log "Ast after propagate_exponents: @[%a@]" Ast.pp_smtlib2 ast2 in
    let var_info = apply_symantics (module Who_in_exponents) ast in
    (* Format.printf "%s: info = @[%a@]\n%!" __FUNCTION__ Info.pp_hum var_info; *)
    let env2, ast2 = eq_propagation var_info ?multiple env ast2 in
    let __ _ = trace_log "env2 = %a" (Env.pp ~title:"") env2 in
    let __ () = trace_log "ast2 = @[%a@]" Ast.pp_smtlib2 ast2 in
    let next_step = next step in
    match
      ( Env.length env2 > Env.length env
      , Ast.equal ast ast2
      , Ast.equal Ast.True ast2 || Ast.equal Ast.false_ ast2 )
    with
    | true, equal, _ ->
      let () = trace_log "%a" (Env.pp ~title:"Something ready to substitute") env2 in
      let __ () = trace_log "ast2 = @[%a@]" Ast.pp_smtlib2 ast2 in
      if not equal then trace_log "iter(%a)= @[%a@]" pp_step next_step Ast.pp_smtlib2 ast2;
      loop next_step (Env.merge_exn env2 env) ast2
    | false, false, false ->
      trace_log "iter(%a)= @[%a@]" pp_step next_step Ast.pp_smtlib2 ast2;
      loop next_step env ast2
    | false, equal, _ ->
      if not equal then trace_log "iter(%a)= @[%a@]" pp_step next_step Ast.pp_smtlib2 ast2;
      trace_log "fixed-point\n";
      (match ast2 with
       | Ast.True -> `Sat env
       | Ast.Lnot Ast.True ->
         (* Below, we are extracting an unsat core *)
         (* Literals, not bare atoms: [collect_atomic] strips [Lnot], so a
            conjunct [(not A)] would be examined -- and later re-asserted in the
            core -- as plain [A]. The core then flips the polarity of a literal of
            the very assignment it is supposed to refute, and the DPLL loop in
            [chro.ml] learns a clause that fails to exclude that assignment. *)
         let contras, trues =
           List.fold_left
             (fun (contras, trues) ph ->
                match subst env ph with
                | Ast.Lnot Ast.True -> ph :: contras, trues
                | Ast.True -> contras, ph :: trues
                | _ -> contras, trues)
             ([], [])
             (Ast.collect_literals orig_ast)
         in
         begin match List.rev contras, List.rev trues with
         | [], _ -> `Unsat orig_ast
         | (atomic :: _ as contras), trues ->
           trace_log "contradicting clause: %a" Ast.pp_smtlib2 atomic;
           trace_log "contradicting env: %a" (Env.pp ~title:"") env;
           (* Every literal that substitutes to [True] under [env] stays in the
              candidate core: the literals that produced a binding substitute
              to [True] under it, so this keeps the core's justification
              closed -- [atomic] is false under [env] and the retained
              literals force [env]. Restricting to the variables reachable
              from [atomic] through env equations used to drop cross-variable
              justifications (e.g. [y = ""] derived from [|x| <= 0] and
              [|x| = |y|]), and the resulting satisfiable "core" became a DPLL
              blocking clause that excluded sat assignments.

              [minimize_core] then shrinks the candidate by verified
              deletions. It is seeded with every contradicting literal, not
              just [atomic]: refuting the first one found may need a long
              chain of justifications while another falls to a two-literal
              core, and deletion filtering can only ever reach cores that are
              subsets of its seed. *)
           let candidate = contras @ trues in
           let core_literals =
             if minimize && List.length candidate <= max_minimized_core_size
             then minimize_core candidate
             else atomic :: trues
           in
           let core = Ast.land_ core_literals in
           trace_log "unsat core: %a\n" Ast.pp_smtlib2 core;
           `Unsat core
         end
       | _ -> `Unknown (ast2, env, var_info, step))
  in
  loop step env orig_ast
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
  let module Map = Base.Map.Poly in
  let open Ast in
  fold
    (fun acc -> function
       (* | Ast.Eia (Eq (lhs, Ast.Eia.Str_const str, S)) -> Ast.Eia.in_re TODO *)
       | Eia (Eq (Eia.Atom (Ast.Var (s, S)), Eia.Str_const str, S)) ->
         (s, Regex.str_to_re str |> Nfa.String.of_regex) :: acc
       | Eia (Eq (Eia.Str_const str, Eia.Atom (Var (s, S)), S)) ->
         (s, Regex.str_to_re str |> Nfa.String.of_regex) :: acc
       (* | Eia (Eq (Eia.Iofs (Eia.Atom (Var (s, S))), Eia.Const n, I)) ->
         (s, Regex.int_to_re (Z.to_string n) |> Nfa.String.of_regex) :: acc
      | Eia (Eq (Eia.Const n, Eia.Iofs (Eia.Atom (Var (s, S))), I)) ->
          (s, Regex.int_to_re (Z.to_string n) |> Nfa.String.of_regex) :: acc *)
       | Eia (InRe (Eia.Atom (Var (s, S)), S, re)) ->
         (s, re |> Nfa.String.of_regex) :: acc
       | Eia (InReRaw (Eia.Atom (Var (s, S)), S, nfa)) -> (s, nfa) :: acc
       | Eia (InReRaw (Eia.Atom (Var (s, I)), I, nfa)) -> (s, nfa) :: acc
       | _ -> acc)
    []
    ast
  |> Map.of_alist_multi
;;

let check_nia env ast =
  let module Z3 = Smtml.Z3_mappings.Solver in
  let to_normal_env =
    Base.Map.Poly.fold ~init:Env.empty ~f:(fun ~key ~data acc ->
      let _ : Env.t = acc in
      let open Ast in
      Env.extend_exn acc (Var (key, I)) (Eia.Const data))
  in
  (* trace_log "ast1=@[%a@]" Ast.pp_smtlib2 ast; *)
  let module M = struct
    include Id_symantics

    let pow_minus_one t = add [ const 1; mul [ const (-2); mod_ t (Z.of_int 2) ] ]
  end
  in
  let ast = apply_symantics_unsugared (module M) ast in
  let ast = lower_mod ast in
  (* trace_log "ast2=@[%a@]" Ast.pp_smtlib2 ast; *)
  let ph = apply_symantics (make_smtml_symantics Utils.Map.empty) ast in
  trace_log "Into Z3 goes: @[%a@]\n%!" Smtml.Expr.pp ph;
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

let rewrite_via_concat { Info.all; _ } =
  let module Map = Base.Map.Poly in
  let gensym1 = gensym in
  let rec gensym () =
    let ans = gensym1 ~prefix:"%substr" () in
    if Set.mem all ans then gensym () else ans
  in
  let extra_ph = ref [] in
  let extend v other =
    extra_ph := Id_symantics.eqz (Id_symantics.var v) other :: !extra_ph
  in
  let extend_eq v other =
    extra_ph := Id_symantics.eq_str (Id_symantics.str_var v) other :: !extra_ph
  in
  let extend_ph ph = extra_ph := ph :: !extra_ph in
  (* Lower identical [str.at]/[str.substr] subterms only once.

     Every [split_vars] call mints seven fresh variables and emits a conditional
     split, so lowering the same subterm twice duplicates the whole encoding and,
     worse, hides from every later pass that the two results denote the same
     string. A formula that mentions [(str.at u (- (str.len u) 1))] four times used
     to get four independent copies of it.

     The arguments are already-rewritten terms by the time we get here, so
     structural equality on them is the right notion of "the same subterm". *)
  let at_cache = ref Map.empty
  and substr_cache = ref Map.empty in
  let memoize cache key build =
    match Map.find !cache key with
    | Some y -> y
    | None ->
      let y = build () in
      cache := Map.set !cache ~key ~data:y;
      y
  in
  let module Rewrite = struct
    include Id_symantics

    let svar v = Ast.Eia.atom (Ast.var v S)

    (* [u], [len_u] name the string being indexed and its length; [z1 . y . z2]
       is the split that extracts the result [y]. Only the split itself is
       conditional: the definitional equations hold in both branches. *)
    let split_vars term =
      let u = gensym () in
      let len_u = gensym () in
      let z1 = gensym () in
      let z2 = gensym () in
      let len_z1 = gensym () in
      let y = gensym () in
      let len_y = gensym () in
      extend_eq u term;
      extend len_u (Ast.Eia.len (svar u));
      extend len_z1 (Ast.Eia.len (svar z1));
      extend len_y (Ast.Eia.len (svar y));
      let split =
        Id_symantics.eq_str (svar u) (Ast.Eia.concat [ svar z1; svar y; svar z2 ])
      in
      u, var len_u, var len_z1, y, var len_y, split
    ;;

    let str_substr (term : str) (offset : term) (len : term) =
      memoize substr_cache (term, offset, len) (fun () ->
        let _u, len_u, len_z1, y, len_y, split = split_vars term in
        let zero = Ast.Eia.const Z.zero in
        let in_range =
          land_
            [ leq zero offset
            ; lt offset len_u
            ; lt zero len
            ; eqz len_z1 offset
            ; split
              (* [|y| = min (len, |u| - m)]: the second disjunct also forces
             [z2 = ""] through [split]. *)
            ; lor_
                [ eqz len_y len
                ; land_
                    [ eqz
                        len_y
                        (Ast.Eia.add
                           [ len_u; Ast.Eia.mul [ Ast.Eia.const Z.minus_one; offset ] ])
                    ; leq len_y len
                    ]
                ]
            ]
        in
        let out_of_range =
          land_
            [ lor_ [ lt offset zero; leq len zero; leq len_u offset ]
            ; eq_str (svar y) (str_const "")
            ]
        in
        extend_ph (lor_ [ in_range; out_of_range ]);
        svar y)
    ;;

    let str_at (term : str) (pos : term) =
      memoize at_cache (term, pos) (fun () ->
        let _u, len_u, len_z1, y, len_y, split = split_vars term in
        let zero = Ast.Eia.const Z.zero in
        let in_range =
          land_
            [ leq zero pos
            ; lt pos len_u
            ; eqz len_z1 pos
            ; eqz len_y (Ast.Eia.const Z.one)
            ; split
            ]
        in
        let out_of_range =
          land_ [ lor_ [ lt pos zero; leq len_u pos ]; eq_str (svar y) (str_const "") ]
        in
        extend_ph (lor_ [ in_range; out_of_range ]);
        svar y)
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
  (* Shared positional decomposition. py-conbyte-style formulas probe the same
     string at many constant offsets ([str.substr s 0 1], [str.at s 3], ...);
     lowering each site through [split_vars] mints an independent seven-variable
     conditional split of the same string, so five sites cost ~35 fresh
     variables and 2^5 branch combinations. Instead, all constant-offset sites
     on one variable share a single segmentation [v = g1 ++ ... ++ gk ++ tail]
     cut at every offset any site needs, with one branch per length window
     [q_j <= |v| < q_j+1] handling the SMT-LIB out-of-range semantics. The
     branch guards are pure length constraints, which the skeleton length
     axioms resolve upfront when |v| is bounded.

     Sharing happens by pre-populating [substr_cache]/[at_cache] before the
     rewrite: sites the collector recognized hit the cache, everything else
     falls back to [split_vars]. A missed cache key (a term the rewriter
     normalizes differently than the input) only loses the sharing, never
     soundness: the fallback encoding is still emitted, and the orphaned shared
     variables stay consistent with it. *)
  let prepopulate_shared ast =
    let module PSet = Base.Set.Poly in
    let site_of_term term =
      let open Ast.Eia in
      match term with
      | Substr (Atom (Ast.Var (v, Ast.S)), Const m, Const l)
        when Z.(geq m zero) && Z.(geq l one) && Z.fits_int m && Z.fits_int l ->
        Some (v, `Seg (Z.to_int m, Z.to_int l))
      | Substr (Atom (Ast.Var (v, Ast.S)), Const m, len)
        when Z.(geq m zero) && Z.fits_int m ->
        (* The "rest of the string from m" pattern: [str.substr v m (|v| - m)]. *)
        let suffix_len =
          match len with
          | Add [ Const c; Len (Atom (Ast.Var (v', Ast.S))) ]
          | Add [ Len (Atom (Ast.Var (v', Ast.S))); Const c ] ->
            String.equal v v' && Z.(equal c (neg m))
          | _ -> false
        in
        if suffix_len then Some (v, `Suffix (Z.to_int m)) else None
      | At (Atom (Ast.Var (v, Ast.S)), Const p) when Z.(geq p zero) && Z.fits_int p ->
        Some (v, `Char (Z.to_int p))
      | _ -> None
    in
    (* [str.at] over a recognized site folds to a site on the base variable:
       [at (substr v m l) p] is [at v (m + p)] when [p < l] and "" when
       [p >= l], both directions of the SMT-LIB out-of-range semantics
       included ([m + p >= |v|] gives "" on both sides). Without this the
       inner site rewrites to a fresh variable first and the outer [at]
       falls back to an independent seven-variable split of it. *)
    let nested_of_term term =
      match term with
      | Ast.Eia.At (inner, Const p) when Z.(geq p zero) && Z.fits_int p ->
        let p = Z.to_int p in
        (match site_of_term inner with
         | Some (v, (`Seg (m, l) as ik)) ->
           Some (v, ik, p, if p < l then Some (`Char (m + p)) else None)
         | Some (v, (`Suffix m as ik)) -> Some (v, ik, p, Some (`Char (m + p)))
         | Some (v, (`Char _ as ik)) -> Some (v, ik, p, if p = 0 then Some ik else None)
         | None -> None)
      | _ -> None
    in
    let sites, nested =
      Ast.fold
        (fun acc -> function
           | Ast.Eia eia ->
             Ast.Eia.fold2
               (fun acc _ -> acc)
               (fun (sites, nested) term ->
                  let sites =
                    match site_of_term term with
                    | Some site -> PSet.add sites site
                    | None -> sites
                  in
                  match nested_of_term term with
                  | Some (v, ik, p, outer) ->
                    let sites =
                      match outer with
                      | Some ok -> PSet.add sites (v, ok)
                      | None -> sites
                    in
                    sites, PSet.add nested (v, ik, p, outer)
                  | None -> sites, nested)
               acc
               eia
           | _ -> acc)
        (PSet.empty, PSet.empty)
        ast
    in
    let by_var =
      PSet.fold sites ~init:Map.empty ~f:(fun acc (v, kind) ->
        Map.add_multi acc ~key:v ~data:kind)
    in
    let nested_by_var =
      PSet.fold nested ~init:Map.empty ~f:(fun acc (v, ik, p, outer) ->
        Map.add_multi acc ~key:v ~data:(ik, p, outer))
    in
    Map.iteri by_var ~f:(fun ~key:v ~data:kinds ->
      if List.length kinds >= 2
      then (
        let svar v = Ast.Eia.atom (Ast.var v S) in
        let const n = Ast.Eia.const (Z.of_int n) in
        let cuts =
          List.concat_map
            (function
              | `Seg (m, l) -> [ m; m + l ]
              | `Suffix m -> [ m ]
              | `Char p -> [ p; p + 1 ])
            kinds
          |> List.sort_uniq Int.compare
          |> List.filter (fun q -> q > 0)
        in
        if not (List.is_empty cuts)
        then (
          let q = Array.of_list (0 :: cuts) in
          let k = Array.length q - 1 in
          let idx_of c =
            let rec go i = if q.(i) = c then i else go (i + 1) in
            go 0
          in
          let segs = Array.init (k + 1) (fun i -> if i = 0 then "" else gensym ()) in
          let tail = gensym () in
          (* Segments covering [q_a, q_b): g_{a+1} .. g_b. *)
          let seg_range a b = List.init (b - a) (fun i -> svar segs.(a + 1 + i)) in
          let concat_or_eps = function
            | [] -> Id_symantics.str_const ""
            | [ t ] -> t
            | ts -> Ast.Eia.concat ts
          in
          let results = List.map (fun kind -> kind, gensym ()) kinds in
          let vlen = Ast.Eia.len (svar v) in
          (* Branch j: q_j <= |v| < q_{j+1} (last branch unbounded above);
             [tail] covers [q_j, |v|), segments beyond j are pinned to "". *)
          let branch j =
            let conds =
              Id_symantics.leq (const q.(j)) vlen
              :: (if j < k then [ Id_symantics.lt vlen (const q.(j + 1)) ] else [])
            in
            let split =
              Id_symantics.eq_str (svar v) (concat_or_eps (seg_range 0 j @ [ svar tail ]))
            in
            let widths =
              List.init j (fun i ->
                Id_symantics.eqz
                  (Ast.Eia.len (svar segs.(i + 1)))
                  (const (q.(i + 1) - q.(i))))
            in
            let empties =
              List.init (k - j) (fun i ->
                Id_symantics.eq_str (svar segs.(j + 1 + i)) (Id_symantics.str_const ""))
            in
            let tail_len =
              Id_symantics.eqz
                (Ast.Eia.len (svar tail))
                (Ast.Eia.add [ vlen; const (-q.(j)) ])
            in
            let site_eqs =
              List.map
                (fun (kind, y) ->
                   let value =
                     match kind with
                     | `Seg (m, l) ->
                       let a = idx_of m
                       and b = idx_of (m + l) in
                       if j < a
                       then Id_symantics.str_const ""
                       else if j < b
                       then concat_or_eps (seg_range a j @ [ svar tail ])
                       else concat_or_eps (seg_range a b)
                     | `Suffix m ->
                       let a = idx_of m in
                       if j < a
                       then Id_symantics.str_const ""
                       else concat_or_eps (seg_range a j @ [ svar tail ])
                     | `Char p ->
                       let a = idx_of p in
                       if j <= a then Id_symantics.str_const "" else svar segs.(a + 1)
                   in
                   Id_symantics.eq_str (svar y) value)
                results
            in
            Id_symantics.land_ (conds @ (split :: tail_len :: widths) @ empties @ site_eqs)
          in
          extend_ph (Id_symantics.lor_ (List.init (k + 1) branch));
          List.iter
            (fun (kind, y) ->
               match kind with
               | `Seg (m, l) ->
                 substr_cache
                 := Map.set !substr_cache ~key:(svar v, const m, const l) ~data:(svar y)
               | `Suffix m ->
                 substr_cache
                 := Map.set
                      !substr_cache
                      ~key:
                        (svar v, const m, Ast.Eia.add [ const (-m); Ast.Eia.len (svar v) ])
                      ~data:(svar y)
               | `Char p ->
                 at_cache := Map.set !at_cache ~key:(svar v, const p) ~data:(svar y))
            results;
          List.iter
            (fun (ik, p, outer) ->
               match List.assoc_opt ik results with
               | None -> ()
               | Some y_inner ->
                 let data =
                   match outer with
                   | None -> Id_symantics.str_const ""
                   | Some ok ->
                     (match List.assoc_opt ok results with
                      | Some y_outer -> svar y_outer
                      | None -> svar y_inner (* only for [`Char _, p = 0] *))
                 in
                 at_cache := Map.set !at_cache ~key:(svar y_inner, const p) ~data)
            (Map.find nested_by_var v |> Option.value ~default:[]))))
  in
  let rec loop ast =
    let ast' = Rewrite.prj (ast |> apply_symantics_unsugared (module Rewrite)) in
    if Ast.is_simpl ast' then ast' else loop ast'
  in
  fun ph ->
    (try prepopulate_shared ph with
     | exn -> trace_log "prepopulate_shared gave up: %s" (Printexc.to_string exn));
    loop ph
;;

let run_length_simplify env ast =
  let open Ast.Eia in
  let open String in
  let to_ prefix name = concat "" [ prefix; name ] in
  let of_ prefix name = sub name (length prefix) (length name - length prefix) in
  let strlen_prefix, stoi_prefix = "@strlen", "@stoi" in
  let len_to_int = function
    | Len (Atom (Var (vn, S))) -> atom (Ast.var (to_ strlen_prefix vn) Ast.I)
    | Iofs (Atom (Var (vn, S))) -> atom (Ast.var (to_ stoi_prefix vn) Ast.I)
    | eia -> eia
  in
  let len_of_int = function
    | Atom (Var (vn, I)) when starts_with ~prefix:strlen_prefix vn ->
      Len (atom (Ast.var (of_ strlen_prefix vn) Ast.S))
    | Atom (Var (vn, I)) when starts_with ~prefix:stoi_prefix vn ->
      Iofs (atom (Ast.var (of_ stoi_prefix vn) Ast.S))
    | eia -> eia
  in
  let map_with f =
    Ast.map (function
      | Eia eia -> Ast.eia (map2 Fun.id f Fun.id eia)
      | ast -> ast)
  in
  match basic_simplify [ 0 ] Env.empty (map_with len_to_int ast) with
  | `Unsat core -> `Unsat (map_with len_of_int core)
  | `Sat env | `Unknown (_, env, _, _) ->
    let extra_eqs =
      Env.to_eqs env
      |> List.filter (fun ast ->
        Set.for_all
          (Ast.collect_vars ast)
          ~f:(Fun.negate (String.starts_with ~prefix:"@")))
      |> Ast.land_
      |> map_with len_of_int
    in
    `Unknown (Ast.land_ [ ast; extra_eqs ])
;;

let under_str env alpha vars ast =
  let module Map = Base.Map.Poly in
  (* A variable is *provably numeric* when replacing its direct
     [str.to_int v] reading with -1 collapses the formula to
     unsatisfiable: every model then has [to_int v >= 0], i.e. [v] is a
     non-empty digit string, and enumerating its candidates over the
     decimal alphabet alone loses nothing. This is the sound form of
     the digit bias -- HashFunction's [mod (to_int x) m = c] proves it,
     while a formula that is satisfiable through [to_int v = -1] (the
     stringfuzz models like [m = "0s"]) keeps the full alphabet. *)
  let proven_digit =
    Ast.get_stoi_vars ast
    |> List.filter (fun v ->
      let ast' =
        Ast.map
          (function
            | Ast.Eia eia ->
              Ast.eia
                (Ast.Eia.map2
                   Fun.id
                   (function
                     | Ast.Eia.Iofs (Ast.Eia.Atom (Ast.Var (u, Ast.S)))
                       when String.equal u v -> Ast.Eia.Const Z.minus_one
                     | t -> t)
                   Fun.id
                   eia)
            | ph -> ph)
          ast
      in
      match basic_simplify [] ~minimize:false env ast' with
      | `Unsat _ -> true
      | `Sat _ | `Unknown _ -> false)
    |> Set.of_list
  in
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
    |> List.sort_uniq (fun x y ->
      match String.length x - String.length y with
      | 0 -> String.compare x y
      | diff -> diff)
    |> fun x ->
    if
      length <= 0
      && NfaS.re_accepts (String.to_seq "" |> List.of_seq) nfa
      && not (List.mem "" x)
    then "" :: x
    else x
  in
  let try_under_str vars alpha len env ast =
    if Set.length vars = 0
    then []
    else (
      let ( let* ) xs f = List.concat_map f xs in
      let envs =
        let regexes =
          Map.map
            ~f:(fun data ->
              List.fold_left
                (fun acc nfa -> NfaS.intersect nfa acc)
                (NfaCollection.LsbString.n ())
                data)
            (collect_regexes ast)
        in
        (* Balance the enumeration against the size of the product it feeds:
           [max_envs] bounds the number of candidate tuples per round, so the
           per-variable count is its [m]-th root -- a single unconstrained
           variable gets thousands of candidates where three variables get a
           handful each, instead of a flat [max_cnt] for every arity. *)
        let per_var =
          let cap = Config.under_str_config.max_envs in
          let m = Set.length vars in
          if cap < 0
          then Config.under_str_config.max_cnt
          else Int.max 2 (Float.to_int (Float.of_int cap ** (1. /. Float.of_int m)))
        in
        (* [base^l], clamped against overflow. *)
        let space base l =
          if l <= 0
          then 1
          else if Float.of_int l *. Float.log2 (Float.of_int base) >= 30.
          then Int.max_int
          else Utils.pow ~base l
        in
        let all_as name =
          let known_len = Ast.get_len name ast in
          let alpha =
            if Set.mem proven_digit name
            then Regex.dec |> String.to_seq |> List.of_seq
            else
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
          let is_regex = Ast.is_conjunct ast && Map.mem regexes name in
          (* A regex-constrained variable gets its ranged enumeration in the
             very first round: its witnesses are as long as the regex pumps,
             so waiting for their exact-length round would push them past the
             caller's time budget. Later rounds still add exact-length
             coverage beyond the initial sample. *)
          (* Regex-constrained variables keep the small flat cap: their
             candidates are pumped words whose length grows with the index,
             and every extra candidate makes both the substitution and the
             automata check on the residual superlinearly more expensive --
             the balanced root budget only makes sense for the flat-cost
             alphabet enumeration. *)
          let per_var =
            if is_regex then min per_var Config.under_str_config.max_cnt else per_var
          in
          (* Multi-variable sets keep the legacy sampler: ranged rounds with
             the flat cap. The balanced exact-length enumeration below is
             only proven for singletons; for products it reshuffles which
             slice of the tuple space gets sampled and loses low-total-length
             witness pairs (the stringfuzz [("0s", "0")] models) that the
             legacy breadth-first order happens to reach. Products get the
             principled treatment when enumeration by total length across
             the set lands. *)
          let legacy = Set.length vars >= 2 in
          let length, exact, count =
            if legacy
            then (
              let max_cnt = Config.under_str_config.max_cnt in
              if known_len >= 0
              then known_len, true, min max_cnt (space (List.length alpha) known_len)
              else if is_regex
              then -1, false, max_cnt
              else len, false, max_cnt)
            else if known_len >= 0
            then known_len, true, min per_var (space (List.length alpha) known_len)
            else if is_regex && len = 0
            then -1, true, per_var
            else len, true, min per_var (space (List.length alpha) len)
          in
          let list =
            get_strings_range
              (if is_regex then Map.find_exn regexes name else nfa_alpha)
              length
              ~exact
              count
          in
          trace_log
            "Strings for %s:\n %a\n%!"
            name
            Format.(
              pp_print_list pp_print_string ~pp_sep:(fun ppf () -> Format.fprintf ppf " "))
            list;
          list
        in
        Set.fold
          ~f:(fun acc name ->
            let* s = all_as name in
            let* acc = acc in
            [ Env.extend_string_exn acc name (Ast.Eia.Str_const s) ])
          ~init:[ env ]
          vars
      in
      envs)
  in
  if Config.under_str_config.max_cnt < 0
  then Seq.empty
  else (
    let filter_asts =
      List.filter_map (fun (env, ast) ->
        (* trace_log "After rewriting via concats:\n%!"; *)
        let var_info = apply_symantics (module Who_in_exponents) ast in
        match
          basic_simplify [ 0 ] ~minimize:false env (ast |> rewrite_via_concat var_info)
        with
        | `Unsat _ -> None
        | `Sat env -> raise_notrace (Str_Underapprox_fired env)
        | `Unknown (ast, env, _, _) -> Some (ast (*|> over_concat_len*), env))
    in
    (* A round can hold thousands of candidate environments, but the caller's
       time budget is only checked between the variants of this sequence, so
       each round is emitted as [max_cnt]-sized chunks -- substitution
       included, lazily per chunk -- to keep that deadline meaningful. A fat
       round would otherwise run to completion long past it. *)
    let chunk_size = Int.max 1 Config.under_str_config.max_cnt in
    let rec chunks lst =
      match lst with
      | [] -> []
      | _ ->
        let hd, tl = Base.List.split_n lst chunk_size in
        hd :: chunks tl
    in
    let m = List.length vars in
    Seq.init (m * (Config.under_str_config.max_len + 1)) (fun x -> x / m, x mod m)
    |> Seq.concat_map (fun (length, side) ->
      match side with
      | n when n >= 0 && n < m ->
        let set = List.nth vars n in
        try_under_str set alpha length env ast
        |> chunks
        |> List.to_seq
        |> Seq.map (fun chunk ->
          filter_asts
            (List.map
               (fun e ->
                  let (module Symantics) = make_main_symantics e in
                  e, apply_symantics (module Symantics) ast)
               chunk))
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
        trace_log "==================================================\n%!";
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
      Ast.lor_ nfas
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
    | Eia eia as ast when is_eia_unsupported eia ->
      unsupported_atomic_formulas := ast :: !unsupported_atomic_formulas;
      false_
    | Lnot (Eia eia) as ast when is_eia_unsupported eia ->
      unsupported_atomic_formulas := ast :: !unsupported_atomic_formulas;
      false_
    | Unsupp _ as ast ->
      unsupported_atomic_formulas := ast :: !unsupported_atomic_formulas;
      true_
    | Lnot ast -> lnot (aux ast)
    | (True | Eia _ | Pred _) as ast -> ast
    | Land xs -> land_ (List.map aux xs)
    | Lor xs -> lor_ (List.map aux xs)
    | Exists (x, v) -> exists x (aux v)
  in
  let ast = aux ast in
  ast, !unsupported_atomic_formulas
;;

let run_string_simplify ast =
  (let module Set = Set in
   match basic_simplify [ 1 ] ~with_nielsen:Config.config.nielsen Env.empty ast with
   | `Sat env -> `Sat env
   | `Unsat unsat_core -> `Unsat unsat_core
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
       else ast' |> find_vars_for_under2s |> fun (x, y) -> [ x; y ]
     in
     let vars = List.rev vars in
     let alpha = collect_alpha ast' in
     let approxed_asts = ast |> under_str e (Utils.with_extra_char alpha) vars in
     let var_info = apply_symantics (module Who_in_exponents) ast' in
     (* trace_log "After rewriting via concats:\n%!"; *)
       (match
          basic_simplify
            [ 0 ]
            e
            (ast' |> rewrite_via_concat var_info (*|> over_concat_len*))
        with
        | `Sat env -> `Sat env
        | `Unsat core -> `Unsat core
        | `Unknown (ast, env, _, _) -> `Unknown (ast, env, approxed_asts)))
  |> fun res -> res
;;

let run_basic_simplify ?(env = Env.empty) ast =
  trace_log "Basic simplifications:\n%!";
  let ast = lower_mod ast in
  (* After [lower_mod]: the congruences it leaves alone are exactly the ones
     [Me] reads; the quotient variables the lowering introduces are folded
     into [Ir.Div] congruences at the IR level ([Ir.exists_to_div]). *)
  let __ _ = trace_log "After strlen lowering:@,@[%a@]\n" Ast.pp_smtlib2 ast in
  if Ast.is_conjunct ast
  then (
    match basic_simplify [ 1 ] env ast with
    | `Sat env -> `Sat env
    | `Unsat core -> `Unsat core
    | `Unknown (ast, e, _, _) ->
      `Unknown (ast |> shrink_variables |> flatten Info.empty, e))
  else `Unknown (ast, env)
;;

let%test_module "unsat core" =
  (module struct
    let wrap f =
      let ast = Ast.land_ (f (make_main_symantics Env.empty)) in
      match run_basic_simplify ast with
      | `Sat _ -> Format.printf "sat\n%!"
      | `Unsat core -> Format.printf "unsat (core = %a)\n%!" Ast.pp_smtlib2 core
      | `Unknown _ -> Format.printf "unknown\n%!"
    ;;

    let%expect_test "basic" =
      wrap (fun (module TS : SYM_SUGAR_AST) ->
        let open TS in
        [ eqz (var "x") (const 3)
        ; eqz (var "x") (const 5)
        ; leq (add [ var "x"; var "y"; var "z" ]) (const 100)
        ]);
      wrap (fun (module TS : SYM_SUGAR_AST) ->
        let open TS in
        [ eqz (var "x") (const 3)
        ; eqz (var "x") (const 5)
        ; eqz (var "x") (const 8)
        ; eqz (var "x") (const 15)
        ; eqz (var "x") (const 25)
        ; leq (add [ var "x"; var "y"; var "z" ]) (const 100)
        ]);
      wrap (fun (module TS : SYM_SUGAR_AST) ->
        let open TS in
        [ eqz (var "x") (const 100); leq (var "x") (const 5) ]);
      (* An irrelevant conjunct that merely evaluates to true under the
         propagated bindings ([z = 30]) must not survive minimization. *)
      wrap (fun (module TS : SYM_SUGAR_AST) ->
        let open TS in
        [ eqz (var "x") (const 3); eqz (var "z") (const 30); eqz (var "x") (const 5) ]);
      (* wrap (fun (module TS : SYM_SUGAR_AST) ->
        let open TS in
    [ leq (var "w") (const 15)
      ; eqz (var "x") (const 10)
      ; eqz (add [var "x"; var "y"]) (const 20)
      ; eqz (var "y") (const 11)
      ; eqz (var "z") (const 30)
      ; leq (var "x") (const 50)
        ]); FIXME: poor simplificator *)
      [%expect
        {|
        unsat (core = (and
                        (= (+ (- 3) x) 0)
                        (= (+ (- 5) x) 0)))
        unsat (core = (and
                        (= (+ (- 3) x) 0)
                        (= (+ (- 25) x) 0)))
        unsat (core = (and
                        (<= (+ (- 5) x) 0)
                        (= (+ (- 100) x) 0)))
        unsat (core = (and
                        (= (+ (- 3) x) 0)
                        (= (+ (- 5) x) 0)))
        |}]
    ;;

    let%expect_test "strings" =
      wrap (fun (module TS : SYM_SUGAR_AST) ->
        let open TS in
        [ eq_str (str_var "x") (str_const "Quentin")
        ; eq_str (str_var "y") (str_var "z")
        ; eqz (iofs (str_var "z")) (const 15)
        ; in_re (str_var "x") (Regex.symbol ("Tarantino" |> String.to_seq |> List.of_seq))
        ]);
      (* wrap (fun (module TS : SYM_SUGAR_AST) ->
        let open TS in
    [ leq (var "w") (const 15)
      ; eqz (var "x") (const 10)
      ; eqz (add [var "x"; var "y"]) (const 20)
      ; eqz (var "y") (const 11)
      ; eqz (var "z") (const 30)
      ; leq (var "x") (const 50)
        ]); FIXME: poor simplificator *)
      [%expect
        {|
        unsat (core = (and
                        (str.in_re x (str.to.re "Tarantino"))
                        (= x "Quentin")))
        |}]
    ;;
  end)
;;

let unfold_neq ast =
  let module Map = Base.Map.Poly in
  let module NfaCL = NfaCollection.LsbStr in
  let atoms v = Ast.Eia.Atom (Ast.Var (v, Ast.S)) in
  let stoi v = Ast.Eia.Iofs (atoms v) in
  let strleni s = Ast.Eia.Len (Ast.Eia.Atom (Ast.Var (s, Ast.S))) in
  (*let ast_if cond ast = if cond then ast else Ast.false_ in*)
  let aux (f : string -> string -> Ast.t) =
    Ast.map (function
      | Ast.Eia
          (Ast.Eia.Neq
             ( Ast.Eia.Atom (Ast.Var (lhs, Ast.S))
             , Ast.Eia.Atom (Ast.Var (rhs, Ast.S))
             , Ast.S )) -> f lhs rhs
      | ast -> ast)
  in
  let asts =
    ast
    |> aux (fun lhs rhs ->
      let ast1 = Ast.eia (Ast.Eia.neq (strleni lhs) (strleni rhs) Ast.I) in
      let ast2 =
        (*let ast =*)
        Ast.land_
          [ Ast.eia (Ast.Eia.eq (strleni lhs) (strleni rhs) Ast.I)
          ; Ast.eia (Ast.Eia.neq (stoi lhs) (stoi rhs) Ast.I)
          ]
        (*in
          ast_if (can_be_both_digit lhs rhs) ast*)
      in
      (* The third case: they are both non-digit strings of the same length; to_int is -1*)
      let ast3 =
        let post
              (model : Model.t)
              (orig_ast : Ast.t)
              (regexes : (string, Nfa.String.t) Map.t)
              (check_sat : Ast.t -> [ `Sat of unit -> Model.t | `Unknown ])
          =
          Debug.trace "post" "Running post check for %s and %s\n" lhs rhs;
          let lhs_re =
            Map.find regexes lhs
            |> Option.map (Nfa.String.intersect (Nfa.String.of_regex Regex.nondigit))
            |> Option.value ~default:(NfaCollection.LsbString.n ())
          in
          let rhs_re =
            Map.find regexes rhs
            |> Option.map (Nfa.String.intersect (Nfa.String.of_regex Regex.nondigit))
            |> Option.value ~default:(NfaCollection.LsbString.n ())
          in
          let find_ineq_from_lengths len =
            let path_to_str a = a |> List.to_seq |> String.of_seq in
            let length_check length =
              Debug.trace "post" "Trying length %d\n" length;
              let return (a, b) = Some (List.take length a, List.take length b) in
              if length > 0
              then (
                let w1 = NfaS.all_paths_of_len lhs_re length in
                let w2 = NfaS.all_paths_of_len rhs_re length in
                if List.length w1 >= 1 && List.length w2 >= 1
                then (
                  let w1, w2, swapped =
                    if List.length w1 >= List.length w2
                    then w1, w2, false
                    else w2, w1, true
                  in
                  let return (a, b) = if swapped then return (b, a) else return (a, b) in
                  match List.nth w1 0, List.nth w2 0 with
                  | a, b when a <> b -> return (a, b)
                  | _, _ when List.length w1 > 1 -> return (List.nth w1 1, List.nth w2 0)
                  | _, _ -> None)
                else None)
              else (
                let path_to_str a = List.map (fun a -> List.nth a 0) a in
                match NfaS.any_path lhs_re [ 0 ], NfaS.any_path rhs_re [ 0 ] with
                | Some (a, _), Some (b, _) -> return (path_to_str a, path_to_str b)
                | _, _ -> None)
            in
            length_check len |> Option.map (fun (a, b) -> path_to_str a, path_to_str b)
          in
          begin
            let get_len model v =
              match Map.find model v with
              | Some (`Str v) -> String.length v
              | Some (`Int v) -> assert false
              | None -> 0
            in
            let rec aux models =
              let ast =
                Ast.land_
                  ([ Ast.eia (Ast.Eia.eq (strleni lhs) (strleni rhs) Ast.I)
                   ; Ast.eia (Ast.Eia.eq (stoi lhs) (stoi rhs) Ast.I)
                   ; Ast.eia
                       (Ast.Eia.eq (stoi lhs) (Id_symantics.constz Z.minus_one) Ast.I)
                   ; Ast.eia (Ast.Eia.leq (Ast.Eia.const Z.one) (strleni lhs))
                   ; orig_ast
                   ]
                   @ List.map Ast.lnot models)
              in
              assert (Ast.is_conjunct ast);
              match check_sat ast with
              | `Sat get_model ->
                let model = get_model () in
                let len = max (get_len model lhs) (get_len model rhs) in
                begin match find_ineq_from_lengths len with
                | Some (a, b) ->
                  `Sat (fun () -> Map.of_alist_exn [ lhs, `Str a; rhs, `Str b ])
                | None when List.length models > 10 -> `Unknown
                | None ->
                  aux
                    (Ast.eia (Ast.Eia.eq (strleni lhs) (Id_symantics.const len) Ast.I)
                     :: models)
                end
              | _ -> `Unknown
            in
            aux []
          end
        in
        Ast.land_
          [ Ast.eia (Ast.Eia.eq (strleni lhs) (strleni rhs) Ast.I)
          ; Ast.eia (Ast.Eia.eq (stoi lhs) (stoi rhs) Ast.I)
          ; Ast.eia (Ast.Eia.eq (stoi lhs) (Id_symantics.constz Z.minus_one) Ast.I)
          ; Ast.eia (Ast.Eia.leq (Ast.Eia.const Z.one) (strleni lhs))
          ; Id_symantics.unsupp_check post
          ]
      in
      Ast.lor_ [ ast1; ast2; ast3 ])
  in
  asts
;;

let arithmetize str_vars ast env =
  let module Set = Set in
  assert (Ast.is_conjunct ast);
  (*let exception StrVar_In_Arithmetize in*)
  let strlens s = String.concat "" [ "strlen"; s ] in
  let pow_base = Ast.Eia.pow (Ast.Eia.const (Z.of_int !Config.base)) in
  (* let in_stoi2 v = Ast.in_stoi2 v ast in *)
  let atomi v = Ast.Eia.Atom (Ast.Var (v, Ast.I)) in
  let module NfaCL = NfaCollection.LsbString in
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
          List.fold_left (fun acc nfa -> Nfa.String.intersect nfa acc) (NfaCL.n ()) data)
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
      if Map.existsi ~f:(fun ~key ~data -> Nfa.String.run data |> not) model_regexes
      then (
        let var, nfa =
          Map.to_alist model_regexes
          |> List.find (fun (key, data) -> NfaS.run data |> not)
        in
        trace_log "find contradicting regex for %s" var;
        Debug.dump_nfa ~msg:"re: %s" NfaS.format_nfa nfa;
        [ Ast.false_ ])
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
            (fun acc nfa -> Nfa.String.intersect nfa acc)
            (NfaCollection.LsbString.n ())
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
      if Map.existsi ~f:(fun ~key ~data -> Nfa.String.run data |> not) regexes
      then (
        let var, nfa =
          Map.to_alist regexes |> List.find (fun (key, data) -> NfaS.run data |> not)
        in
        trace_log "find contradicting (integer) regex for %s" var;
        Debug.dump_nfa ~msg:"re: %s" NfaS.format_nfa nfa;
        [ Ast.false_ ])
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
      if Set.mem all ans then gensym () else ans
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
      extra_ph
      := Id_symantics.unsupp
           (s ^ " in unsupported concat")
           (Smtml.Expr.value Smtml.Value.False)
         :: !extra_ph
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
        function
        | s when contains_var str_vars s -> Id_symantics.constz Z.minus_one
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
  let arithmetize var_info str_vars ast =
    let (module M) = make_main_symantics Env.empty in
    let in_stoi v = Ast.in_stoi v ast in
    let open Ast.Eia in
    (* Previously, Chrobelias tried to approximate concatenation of pure-digit
        strings $a ++ b$ as $a \times 10^(str.len b) + b$. However, the further
        multiplication approximations are extremely slow. For now the behavior is disabled *)
    (*let in_stoi_or_concat v = Ast.in_stoi v ast || Ast.in_concat v ast in*)
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
              let regexes = collect_regexes ast in
              let in_regex = Map.mem regexes in
              let phs =
                (match in_stoi var, List.mem var str_vars with
                 | true, false -> leq (const Z.one) v
                 | _, _ -> leq (const Z.zero) v)
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
                :: lt term' (Mul [ const (Z.of_int !Config.base); pow_base v ])
                :: phs
              in
              v, phs
            | Str_const s ->
              begin try const (Z.of_string s), [] with
              | Invalid_argument v ->
                let () = Format.printf "something is wrong %s" s in
                failwith v
              end
              (*| Atom (Var (v, S)) when List.mem v str_vars -> const Z.minus_one, []*)
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
    let arithmetize_in_re s nfa : Ast.t =
      if nfa |> Nfa.String.run |> not
      then Ast.false_
      else (
        trace_log "Arithmetizing regex ... for variable %s" s;
        let strlens = strlens s in
        let csds =
          let is_eos vec =
            match Array.length vec with
            | 1 -> Char.equal (Array.get vec 0) Nfa.Str10.u_eos
            | _ -> failwith "unexpected nfa in arithmetize_in_re"
          in
          Nfa.String.filter_map nfa (fun (label, q') ->
            if is_eos label then Option.none else Option.some (label, q'))
          |> Nfa.String.to_nat
          |> Nfa.String.chrobak
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
    let rec arithmetize_conj str_vars : Ast.t -> Ast.t =
      fun ast ->
      match ast with
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
          if not (in_stoi s)
          then nfa
          else if List.mem s str_vars
          then Regex.nondigit |> Nfa.String.of_regex |> Nfa.String.intersect nfa
          else Regex.digit |> Nfa.String.of_regex |> Nfa.String.intersect nfa
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
    (* |> fun ast' ->
      trace_log "arithmetize(%a) -> %a" Ast.pp_smtlib2 ast Ast.pp_smtlib2 ast';
    ast' *)
  in
  let var_info = apply_symantics (module Who_in_exponents) ast in
  let alpha = alpha_with_extra_char ast in
  let (module Symantics) = make_main_symantics ~alpha env in
  (*Format.printf "STR_VARS %a\n%!" (Format.pp_print_list Format.pp_print_string) str_vars;
  Format.printf "1 -> %a\n%!" Ast.pp_smtlib2 ast;*)
  let with_empty_cases ast =
    let open Ast in
    let open Ast.Eia in
    let important_vars = get_stoi_conc_vars ast in
    Utils.powerset_seq important_vars
    |> Seq.map (fun empty_vars ->
      List.map (fun var -> eia (Eq (Atom (Var (var, S)), str_const "", S))) empty_vars)
    |> Seq.map (fun ast' -> land_ (ast :: ast'))
  in
  ast
  |> split_concats
  |> Ast.to_dnf_seq
  (*|> List.map (fun ast ->
    Format.printf "2 -> %a\n%!" Ast.pp_smtlib2 ast; ast)*)
  |> (fun s -> if Config.config.light_dpll then s else Seq.concat_map with_empty_cases s)
  |> Seq.map (apply_symantics (module Symantics))
  |> Seq.filter_map (fun ast ->
    match basic_simplify [ 0 ] ~minimize:false env ast with
    | `Unsat _core ->
      (*Format.printf "missed unsat core %a\n%!" Ast.pp_smtlib2 core;*) None
    | `Sat env -> Some (Ast.true_, env)
    | `Unknown (ast, env, _, _) -> Some (ast, env))
  |> Seq.concat_map (fun (ast, env) ->
    Seq.map (fun ast -> ast, env) (ast |> split_concats |> Ast.to_dnf_seq))
  |> Seq.map (fun (ast, env) -> fold_regexes ~str_vars ast, env)
  |> Seq.map (fun ((ast, regexes), env) ->
    (*Format.printf "3 -> %a\n%!" Ast.pp_smtlib2 ast; *) ast, regexes, env)
  |> Seq.concat_map (fun (ast, regexes, env) ->
    arithmetize var_info str_vars ast
    |> Ast.to_dnf_seq
    |> Seq.map (fun ast' ->
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
      ast', env, regexes))
;;

module NondeterministicMonad = struct
  (* type 'a t = 'a Seq.t *)

  let return = Seq.return
  let bind m f = Seq.flat_map f m
  let ( let* ) = bind
end

let rec multiply_constraint_by_int int =
  let open Ast.Eia in
  let (module TS) = make_main_symantics Env.empty in
  function
  | ast when Z.(int = one) -> ast
  | Ast.Eia (Eq (Mod (t, d), Const z, I)) when Z.(equal z zero) ->
    TS.(
      Ast.Eia
        (Eq (Mod (mul [ constz (Z.abs int); t ], Z.(abs (d * int))), constz Z.zero, I)))
  | Ast.Eia (Eq (l, Mod (t, d), I)) ->
    Ast.Eia
      (Eq (TS.(mul [ constz int; l ]), Mod (TS.(mul [ constz int; t ]), Z.(d * int)), I))
  | Ast.Eia (Eq (l, r, I)) ->
    Ast.Eia (Eq (TS.(mul [ constz int; l ]), TS.(mul [ constz int; r ]), I))
  | Ast.Eia (Leq (l, r)) when int > Z.zero ->
    Ast.Eia (Leq (TS.(mul [ constz int; l ]), TS.(mul [ constz int; r ])))
  | Ast.Eia (Leq (l, r)) ->
    Ast.Eia (Leq (TS.(mul [ constz int; r ]), TS.(mul [ constz int; l ])))
  | Ast.Land xs -> Ast.Land (List.map (multiply_constraint_by_int int) xs)
  | Ast.Lor xs -> Ast.Lor (List.map (multiply_constraint_by_int int) xs)
  | x -> x
;;

let print_ph_list ?(margin = 160) ?(max_indent = 160) ?(buffer_size = 1024) pp lst =
  let buf = Buffer.create buffer_size in
  let fmt = Format.formatter_of_buffer buf in
  Format.pp_set_margin fmt margin;
  Format.pp_set_max_indent fmt max_indent;
  List.iter (Format.fprintf fmt "%a\n" pp) lst;
  Format.pp_print_flush fmt ();
  print_string (Buffer.contents buf)
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test a ph_list =
    let ph_list = List.map (multiply_constraint_by_int a) ph_list in
    print_ph_list Ast.pp ph_list
  in
  let ph =
    TS.
      [ add [ mul [ const 2; var "x" ]; var "y" ] = const 1
      ; add [ var "x"; mul [ const 2; var "y" ]; var "z" ] = const 3
      ; add [ var "y"; mul [ const 2; var "z" ] ] = const 3
      ]
  in
  test (Z.of_int 5) ph;
  [%expect
    {|
    (= (+ (* (- 1) 5) (* (* 2 x) 5) (* y 5)) 0)
    (= (+ (* (- 3) 5) (* x 5) (* (* 2 y) 5) (* z 5)) 0)

    (= (+ (* (- 3) 5) (* y 5) (* (* 2 z) 5)) 0)
    |}]
;;

let coeff_of_var varname term =
  let open Ast.Eia in
  let rec flatten_mul = function
    | Mul ts -> List.concat_map flatten_mul ts
    | t -> [ t ]
  in
  let rec aux = function
    | Atom (Var (v, I)) when v = varname -> Z.one
    | Add ts -> List.fold_left (fun acc t -> Z.add acc (aux t)) Z.zero ts
    | Mul ts ->
      let flat = List.concat_map flatten_mul ts in
      let rec scan const_acc var_seen = function
        | [] when var_seen -> const_acc
        | [] -> Z.zero
        | Const c :: rest -> scan (Z.mul const_acc c) var_seen rest
        | Atom (Var (v, I)) :: rest when v = varname && not var_seen ->
          scan const_acc true rest
        | Atom (Var (v, I)) :: rest when v = varname && var_seen ->
          failwith "Expected linear equations"
        | _ :: _ -> Z.zero
      in
      scan Z.one false flat
    | Mod (t, _) -> aux t
    | _ -> Z.zero
  in
  aux term
;;

let substitute_vigorous_constraint varname coeff tau ast =
  let open Ast.Eia in
  let (module TS) = make_main_symantics Env.empty in
  let ast = apply_symantics (module TS) ast in
  let rec aux = function
    | Add ts -> TS.add (List.map aux ts)
    | Atom (Var (v, I)) when v = varname && Z.(coeff = minus_one) -> tau
    | Atom (Var (v, I)) when v = varname && Z.(coeff = one) ->
      TS.(mul [ const (-1); tau ])
    | Mul ts as t ->
      begin match coeff_of_var varname t with
      | c when not (Z.equal c Z.zero) ->
        assert (Z.(equal (c mod coeff) zero));
        let factor = Z.div c coeff in
        TS.(mul [ constz (Z.neg factor); tau ])
      | _ -> TS.mul (List.map aux ts)
      end
    | Mod (t, d) -> TS.mod_ (aux t) d
    | Pow (b, e) -> TS.pow (aux b) (aux e)
    | t -> t
  in
  match ast with
  | Ast.Eia (Eq (l, r, I)) -> TS.(aux l = aux r)
  | Ast.Eia (Leq (l, r)) -> TS.(aux l <= aux r)
  | _ -> ast
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ph_list a tau x =
    let ph_list =
      ph_list
      |> List.map (multiply_constraint_by_int a)
      |> List.map (substitute_vigorous_constraint x a tau)
      |> List.map (apply_symantics (module TS))
    in
    print_ph_list Ast.pp ph_list
  in
  let ph =
    TS.
      [ add [ mul [ const 2; var "x" ]; var "y" ] = const 1
      ; add [ var "x"; mul [ const 2; var "y" ]; var "z" ] = const 3
      ; add [ var "y"; mul [ const 2; var "z" ] ] = const 3
      ]
  in
  test ph (Z.of_int 2) TS.(add [ var "y"; const (-1) ]) "x";
  [%expect
    {|
    True
    (= (+ (- 5) (* 2 z) (* 3 y)) 0)
    (= (+ (- 6) (* 2 y) (* 4 z)) 0)
    |}]
;;

let introduce_slacks conjs =
  let open Ast.Eia in
  let slack_vars = ref [] in
  let new_conjs =
    List.map
      (function
        | Ast.Eia (Leq (l, r)) ->
          let y = gensym ~prefix:"_slack_" () in
          slack_vars := y :: !slack_vars;
          Ast.eia (Eq (add [ l; atom (Var (y, I)) ], r, I))
        | other -> other)
      conjs
  in
  !slack_vars, new_conjs
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ph_list =
    let _, ph = introduce_slacks ph_list in
    print_ph_list Ast.pp ph
  in
  let ph =
    TS.
      [ add [ mul [ const 2; var "x" ]; var "y" ] <= const 1
      ; add [ var "x"; mul [ const 2; var "y" ]; var "z" ] <= const 3
      ; add [ var "y"; mul [ const 2; var "z" ] ] <= const 3
      ]
  in
  test ph;
  [%expect
    {|
    (= (+ (- 1) (* 2 x) y _slack_1) 0)
    (= (+ (- 3) x (* 2 y) z _slack_2) 0)

    (= (+ (- 3) y (* 2 z) _slack_3) 0)
    |}]
;;

let get_mod_phi_of_system =
  let open Ast.Eia in
  let compute_mod eia =
    match eia with
    | Eq (Mod (_, d), Const c, I) when Z.equal c Z.zero -> d
    | _ -> Z.one
  in
  List.fold_left
    (fun acc -> function
       | Ast.Eia eia -> Z.lcm acc (compute_mod eia)
       | _ -> acc)
    Z.one
;;

let first_n_numbers z =
  let last = Z.(z - one) in
  let rec aux i acc = if i > last then List.rev acc else aux Z.(i + one) (i :: acc) in
  aux Z.zero []
;;

let var_exists varname conj =
  List.exists
    (function
      | Ast.Eia (Eq (Mod _, _, I)) -> false
      | Ast.Eia (Eq (l, r, I)) ->
        coeff_of_var varname l <> Z.zero || coeff_of_var varname r <> Z.zero
      | _ -> false)
    conj
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ph_list varname =
    if var_exists varname ph_list
    then Format.printf "Found\n"
    else Format.printf "Not found\n"
  in
  let ph =
    TS.
      [ add [ mul [ const 2; var "x" ]; var "y" ] = const 1
      ; add [ var "x"; mul [ const 2; var "y" ]; var "z" ] = const 3
      ; add [ var "y"; mul [ const 2; var "z" ] ] = const 3
      ]
  in
  test ph "y";
  [%expect {| Found |}];
  test ph "x";
  [%expect {| Found |}];
  test ph "z";
  [%expect {| Found |}];
  test ph "q";
  [%expect {| Not found |}]
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ph_list varname =
    let string = coeff_of_var varname ph_list |> Z.to_string in
    Format.printf "%s\n" string
  in
  let ph = TS.(add [ mul [ const 2; var "x" ]; var "y" ]) in
  let ph1 = TS.(add [ mul [ const 2; var "x" ]; mul [ const 2; var "x" ] ]) in
  test ph "y";
  [%expect {| 1 |}];
  test ph "x";
  [%expect {| 2 |}];
  test ph "z";
  [%expect {| 0 |}];
  test ph1 "x";
  [%expect {| 4 |}]
;;

let find_var_and_coeff varname =
  let open Ast.Eia in
  function
  | Ast.Eia.Eq (Mod _, _, I) -> None
  | Ast.Eia.Eq (l, r, I) ->
    let coeff_l = coeff_of_var varname l in
    let coeff_r = coeff_of_var varname r in
    let coeff = Z.(coeff_l - coeff_r) in
    if Z.(coeff <> zero)
    then begin
      let (module TS) = make_main_symantics Env.empty in
      let env = Env.extend_int_exn Env.empty varname (const Z.zero) in
      let tau = TS.(add [ l; mul [ const (-1); r ] ]) in
      let tau_no_x = subst_term env tau in
      Some (coeff, tau_no_x)
    end
    else None
  | _ -> None
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let ph =
    TS.
      [ add [ mul [ const 2; var "x" ]; var "y" ] = const 1
      ; add [ var "x"; mul [ const 2; var "y" ]; var "z" ] = const 3
      ; add [ var "y"; mul [ const 2; var "z" ] ] = const 3
      ]
  in
  let varname = "y" in
  let rez =
    List.map
      (function
        | Ast.Eia eia -> find_var_and_coeff varname eia
        | _ -> None)
      ph
  in
  let _ =
    rez
    |> List.map (function
      | Some (coeff, tau) ->
        Format.printf "Found something\n";
        Z.to_string coeff |> Format.printf "Coeff: %s\n";
        Format.printf "Term without selected variable: %a\n" Ast.Eia.pp_term tau
      | None -> Format.printf "None\n")
  in
  ();
  [%expect
    {|
    Found something
    Coeff: 1
    Term without selected variable: (+ (- 1) (* 2 x))
    Found something
    Coeff: 2
    Term without selected variable:
    (+ (- 3) x z)
    Found something
    Coeff: 1
    Term without selected variable:
    (+ (- 3) (* 2 z))
    |}]
;;

let rec slack_vars_in_term (subst : Env.t) =
  let open Ast.Eia in
  let has_slack_prefix = String.starts_with ~prefix:"_slack_" in
  function
  | Atom (Var (varname, I))
    when Env.lookup_int varname subst = None && has_slack_prefix varname -> [ varname ]
  | Add xs | Mul xs -> List.concat_map (slack_vars_in_term subst) xs
  | Mod (term, _) -> slack_vars_in_term subst term
  | Pow (term, _) -> slack_vars_in_term subst term
  | _ -> []
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ph_list =
    let env = Env.empty |> fun x -> Env.extend_int_exn x "_slack_1" (Const Z.one) in
    let found =
      List.concat_map
        (function
          | Ast.Eia (Eq (l, r, I)) -> slack_vars_in_term env l @ slack_vars_in_term env r
          | _ -> assert false)
        ph_list
    in
    print_ph_list Format.pp_print_string found
  in
  let ph =
    TS.
      [ add [ mul [ const 2; var "x" ]; var "y"; var "_slack_1" ] = const 1
      ; add [ var "x"; mul [ const 2; var "y" ]; var "z"; var "_slack_2" ] = const 3
      ; add [ var "y"; mul [ const 2; var "z" ]; var "_slack_3" ] = const 3
      ]
  in
  test ph;
  [%expect
    {|
    _slack_2
    _slack_3
    |}]
;;

let eliminate_one_var conj varname subst p l =
  let open Ast in
  let open NondeterministicMonad in
  let (module TS) = make_main_symantics Env.empty in
  let eqs =
    List.filter_map
      (function
        | Ast.Eia eia -> find_var_and_coeff varname eia
        | _ -> None)
      conj
  in
  if eqs = []
  then return (conj, subst, p, l)
  else
    let* coeff, tau = List.to_seq eqs in
    let p = l in
    let l = coeff in
    let slacks = slack_vars_in_term subst tau in
    let mod_phi = get_mod_phi_of_system conj in
    let possible_vals = first_n_numbers Z.(Z.abs coeff * mod_phi) |> List.to_seq in
    let* subst =
      if slacks = []
      then return subst
      else begin
        let rec loop acc = function
          | [] -> return acc
          | x :: xs ->
            let* v = possible_vals in
            let acc = Env.extend_int_exn acc x (Ast.Eia.const v) in
            loop acc xs
        in
        loop subst slacks
      end
    in
    let conj =
      conj
      |> List.map (multiply_constraint_by_int coeff)
      |> List.map (substitute_vigorous_constraint varname coeff tau)
      |> fun x -> divides (Z.abs coeff) tau :: x |> List.map (apply_symantics (module TS))
    in
    return (conj, subst, p, l)
;;

let subst_eia subst =
  let subst_term eta = subst_term subst eta in
  function
  | Ast.Eia (Ast.Eia.Eq (l, r, I)) -> Ast.Eia (Ast.Eia.Eq (subst_term l, subst_term r, I))
  | Ast.Eia (Ast.Eia.Leq (l, r)) -> Ast.Eia (Ast.Eia.Leq (subst_term l, subst_term r))
  | ast -> ast
;;

let eliminate_existence_quantifier_branches (ast : Ast.t) =
  let open NondeterministicMonad in
  match ast with
  | Exists (elim_vars, ast) ->
    begin match ast with
    | Land conj_list ->
      let slack, conj_list = introduce_slacks conj_list in
      let elim_vars =
        List.map
          (function
            | Ast.Any_atom (Var (varname, I)) -> varname
            | _ -> failwith "Expected only integer variables")
          elim_vars
      in
      let rec eliminate_all subst conj p l = function
        | [] -> return (conj, subst)
        | h :: tl ->
          let* conj, subst, p, l = eliminate_one_var conj h subst p l in
          eliminate_all subst conj p l tl
      in
      let* branch, subst = eliminate_all Env.empty conj_list Z.one Z.one elim_vars in
      let branch =
        List.map
          (function
            | Ast.Eia (Ast.Eia.Eq (Mod _, _, I)) as t -> t
            | Ast.Eia (Ast.Eia.Eq (l, r, I)) as t -> begin
              slack_vars_in_term subst r @ slack_vars_in_term subst l
              |> List.find_opt (fun x -> Env.lookup_int x subst = None)
              |> function
              | Some varname ->
                let env = Env.extend_int_exn Env.empty varname (Ast.Eia.Const Z.zero) in
                begin match coeff_of_var varname l, coeff_of_var varname r with
                | c, z when c > Z.zero && Z.(z = zero) ->
                  Ast.Eia (Leq (subst_term env l, r))
                | c, z when Z.(z = zero) -> Ast.Eia (Leq (r, subst_term env l))
                | z, c when c > Z.zero && Z.(z = zero) ->
                  Ast.Eia (Leq (l, subst_term env r))
                | z, c when Z.(z = zero) -> Ast.Eia (Leq (subst_term env r, l))
                | _, _ -> assert false
                end
              | None -> t
              end
            | t -> t)
          branch
      in
      let branch = List.map (subst_eia subst) branch in
      let mod_phi = get_mod_phi_of_system branch in
      let possible_vals = first_n_numbers mod_phi |> List.to_seq in
      let rec loop env phi = function
        | [] -> return env
        | h :: tl when var_exists h phi ->
          let* v = possible_vals in
          let env = Env.extend_int_exn env h (Ast.Eia.Const v) in
          loop env phi tl
        | h :: tl -> loop env phi tl
      in
      let helper_filter = function
        | Ast.Eia (Ast.Eia.Eq (Ast.Eia.Mod (l, o), Const z, I))
          when Z.(equal z zero && equal o one) -> false
        | Ast.True -> false
        | t -> true
      in
      let* env = loop Env.empty branch elim_vars in
      branch |> List.map (subst_eia env) |> List.filter helper_filter |> return
    | _ -> failwith "Expected a conjuction"
    end
  | _ -> failwith "Expected the existence quantifier"
;;

let eliminate_existence_quantifier (ast : Ast.t) : Ast.t =
  let open Ast in
  let branches = eliminate_existence_quantifier_branches ast in
  List.of_seq branches |> List.map (fun x -> land_ x) |> lor_
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ph_list a x tau =
    let ph_list =
      ph_list
      |> List.map (multiply_constraint_by_int a)
      |> List.map (substitute_vigorous_constraint x a tau)
      |> List.map (apply_symantics (module TS))
    in
    print_ph_list Ast.pp ph_list
  in
  let ph = TS.[ add [ mul [ const (-1); var "x0" ] ] = const (-55) ] in
  let tau =
    Ast.Eia.add
      [ Ast.Eia.mul [ Ast.Eia.Const (Z.of_int (-1)); Ast.Eia.Atom (Ast.Var ("x1", I)) ]
      ; Ast.Eia.Const (Z.of_int (-217))
      ]
  in
  test ph (Z.of_int 4) "x0" tau;
  [%expect {| (= (+ 3 (* (- 1) x1)) 0) |}]
;;

let rec is_linear_term =
  let open Ast.Eia in
  let has_one_variable xs =
    let rec aux acc = function
      | [] -> acc = 1
      | Atom _ :: xs -> aux (acc + 1) xs
      | x :: xs -> aux acc xs
    in
    aux 0 xs
  in
  function
  | Const _ -> true
  | Atom _ -> true
  | Add xs -> List.for_all is_linear_term xs
  | Mul xs -> List.for_all is_linear_term xs && has_one_variable xs
  | Mod (xs, _) -> is_linear_term xs
  | _ -> false
;;

let is_linear_system =
  let rec aux = function
    | Ast.Land conj -> List.for_all aux conj
    | Ast.Eia (Ast.Eia.Leq (l, r)) -> is_linear_term l && is_linear_term r
    | Ast.Eia (Ast.Eia.Eq (l, r, I)) -> is_linear_term l && is_linear_term r
    | _ -> false
  in
  function
  | Ast.Land conj -> List.for_all aux conj
  | _ -> false
;;

let is_linear_constraint = function
  | Ast.Eia (Ast.Eia.Leq (l, r)) -> is_linear_term l && is_linear_term r
  | Ast.Eia (Ast.Eia.Eq (l, r, I)) -> is_linear_term l && is_linear_term r
  | _ -> false
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ph = Format.printf "%b\n" (is_linear_system ph) in
  let ph0 =
    TS.(
      Ast.Land
        [ add [ mul [ const (-1); var "x0" ] ] = const (-55)
        ; add [ mul [ const 4; var "x0" ]; mul [ const (-1); var "x1" ] ] = const 217
        ])
  in
  let ph1 =
    TS.(
      Ast.Land
        [ add [ mul [ const (-1); var "x0"; var "x0" ] ] = const (-55)
        ; add [ mul [ const 4; var "x0" ]; mul [ const (-1); var "x1" ] ] = const 217
        ])
  in
  test ph0;
  test ph1;
  [%expect
    {|
    true
    false
    |}]
;;

let simplify_quantifiers (ast : Ast.t) =
  let open Ast in
  let rec aux = function
    | Ast.Exists (_, ast) as eq when is_linear_system ast ->
      eliminate_existence_quantifier eq
    | Ast.Exists (atoms, ast) when is_linear_constraint ast ->
      eliminate_existence_quantifier (exists atoms (Ast.Land [ ast ]))
    | Ast.Exists (atoms, ast) -> exists atoms (aux ast)
    | Ast.Lnot ast -> lnot (aux ast)
    | Ast.Land ast -> land_ (List.map aux ast)
    | Ast.Lor ast -> lor_ (List.map aux ast)
    | ast -> ast
  in
  aux ast
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ph =
    let set = simplify_quantifiers ph in
    print_ph_list Ast.pp [ set ]
  in
  let ph =
    TS.(
      Ast.Exists
        ( [ Ast.Any_atom (Ast.Var ("x0", I)) ]
        , Ast.Land
            [ add [ mul [ const (-1); var "x0" ] ] = const (-55)
            ; add [ mul [ const 4; var "x0" ]; mul [ const (-1); var "x1" ] ] = const 217
            ] ))
  in
  test ph;
  [%expect
    {| ((= (+ (- 3) x1) 0) | ((divides 4 (+ (- 217) (* (- 1) x1))) & (= (+ 3 (* (- 1) x1)) 0))) |}]
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ph =
    let set = simplify_quantifiers ph in
    Format.printf "%a\n" Ast.pp set
  in
  let ph =
    TS.(
      Ast.Exists
        ( [ Ast.Any_atom (Ast.Var ("x0", I)); Ast.Any_atom (Ast.Var ("x1", I)) ]
        , Ast.Land
            [ add [ mul [ const (-1); var "x0" ]; mul [ const (-1); var "x1" ] ]
              = const (-22)
            ; add [ mul [ const (-4); var "x0" ]; mul [ const (-3); var "x1" ] ]
              = const (-76)
            ] ))
  in
  test ph;
  [%expect {| True |}]
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ph =
    let ph = simplify_quantifiers ph in
    Format.printf "%a\n" Ast.pp ph
  in
  let ph =
    TS.(
      Ast.Exists
        ( [ Ast.Any_atom (Ast.Var ("x0", I)) ]
        , Ast.Land
            [ add [ mul [ const 1; var "x0" ] ] = const 6
            ; add [ mul [ const (-4); var "x0" ]; mul [ const 1; var "x1" ] ] = const 29
            ] ))
  in
  test ph;
  [%expect
    {| ((= (+ (- 53) x1) 0) | ((divides 4 (+ (- 29) x1)) & (= (+ 53 (* (- 1) x1)) 0))) |}]
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ph =
    let ph = simplify_quantifiers ph in
    Format.printf "%a\n" Ast.pp ph
  in
  let ph =
    TS.(
      Ast.Exists
        ( [ Ast.Any_atom (Ast.Var ("x0", I)) ]
        , Ast.Land
            [ add [ mul [ const (-1); var "x0" ] ] = const (-82)
            ; add [ mul [ const 4; var "x0" ]; mul [ const 1; var "x1" ] ] = const 425
            ] ))
  in
  test ph;
  [%expect
    {| ((= (+ 97 (* (- 1) x1)) 0) | ((divides 4 (+ (- 425) x1)) & (= (+ (- 97) x1) 0))) |}]
;;

let%expect_test _ =
  let (module TS) = make_main_symantics Env.empty in
  let test ph =
    let ph = simplify_quantifiers ph in
    Format.printf "%a\n" Ast.pp ph
  in
  let ph =
    TS.(
      Ast.Exists
        ( [ Ast.Any_atom (Ast.Var ("x0", I)); Ast.Any_atom (Ast.Var ("x1", I)) ]
        , Ast.Land
            [ add [ mul [ const (-1); var "x0" ]; mul [ const (-3); var "x1" ] ]
              = const (-285)
            ; add [ mul [ const (-2); var "x0" ]; mul [ const (-7); var "x1" ] ]
              = const (-660)
            ] ))
  in
  test ph;
  [%expect {| True |}]
;;
