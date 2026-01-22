(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)
let compare_string = String.compare
let compare_int = Int.compare
let compare_list f = Base.List.compare f
let compare_char = Char.compare

type 'a kind =
  | I : Z.t kind
  | S : string kind

type 'a atom = Var : string * 'a kind -> 'a atom [@@deriving variants]

let failf fmt = Format.kasprintf failwith fmt
let str_var name = Var (name, S)
let int_var name = Var (name, I)

type any_atom = Any_atom : 'a atom -> any_atom

let compare_any_atom l r =
  match l, r with
  | Any_atom (Var (v1, _)), Any_atom (Var (v2, _)) -> String.compare v1 v2
;;

let pp_atom ppf = function
  | Var (n, _) -> Format.fprintf ppf "%s" n
;;

let pp_any_atom ppf = function
  | Any_atom a -> Format.fprintf ppf "%a" pp_atom a
;;

module Eq = struct
  type (_, _) t = Eq : ('a, 'a) t

  let refl : ('a, 'a) t = Eq

  let sym (type a b) : (a, b) t -> (b, a) t =
    fun p ->
    match p with
    | Eq -> Eq
  ;;

  let cast (type a b) (proof : (a, b) t) (x : a) : b =
    match proof with
    | Eq -> x
  ;;
end

module NfaS = Nfa.Lsb (Nfa.Str)

module Eia = struct
  (** Exponential integer arithmetic, i.e. LIA with exponents.*)

  type 'a term =
    | Const : Z.t -> Z.t term
    | Str_const : string -> string term
    | Atom : 'a atom -> 'a term
    | Len : string term -> Z.t term
    | Add : Z.t term list -> Z.t term
    | Mul : Z.t term list -> Z.t term
    | Mod : Z.t term * Z.t -> Z.t term
    | Bwand : Z.t term * Z.t term -> Z.t term
    | Bwor : Z.t term * Z.t term -> Z.t term
    | Bwxor : Z.t term * Z.t term -> Z.t term
    | Pow : Z.t term * Z.t term -> Z.t term
    (* String stuff *)
    | Sofi : Z.t term -> string term
    | Iofs : string term -> Z.t term
    | Len2 : string term -> Z.t term
    | Concat : string term * string term -> string term
    | At : string term * Z.t term -> string term
    | Substr : string term * Z.t term * Z.t term -> string term
  [@@deriving variants]

  let rec pp_term : 'a. Format.formatter -> 'a term -> unit =
    fun (type a) ppf : (a term -> unit) -> function
    | Const c when Z.lt c Z.zero -> Format.fprintf ppf "(- %a)" Z.pp_print (Z.( ~- ) c)
    | Const c -> Z.pp_print ppf c
    | Str_const s -> Format.fprintf ppf "\"%s\"" s
    | Atom atom -> Format.fprintf ppf "%a" pp_atom atom
    | Len s -> Format.fprintf ppf "(str.len %a)" pp_term s
    | Iofs s -> Format.fprintf ppf "(str.to.int %a)" pp_term s
    | Sofi eia -> Format.fprintf ppf "(str.from_int %a)" pp_term eia
    | Add xs ->
      Format.fprintf
        ppf
        "@[(+ %a)@]"
        (Format.pp_print_list pp_term ~pp_sep:Format.pp_print_space)
        xs
    | Mul xs ->
      Format.fprintf
        ppf
        "@[(* %a)@]"
        (Format.pp_print_list pp_term ~pp_sep:Format.pp_print_space)
        xs
    | Bwor (a, b) -> Format.fprintf ppf "(%a | %a)" pp_term a pp_term b
    | Bwxor (a, b) -> Format.fprintf ppf "(%a ^ %a)" pp_term a pp_term b
    | Bwand (a, b) -> Format.fprintf ppf "(%a & %a)" pp_term a pp_term b
    | Pow (a, b) -> Format.fprintf ppf "(exp %a %a)" pp_term a pp_term b
    | Len2 a -> Format.fprintf ppf "@[(chrob.len %a)@]" pp_term a
    | Mod (t, z) -> Format.fprintf ppf "(mod %a %a)" pp_term t Z.pp_print z
    (* Strings  *)
    | Concat (s1, s2) -> Format.fprintf ppf "@[(str.++ %a %a)@]" pp_term s1 pp_term s2
    | Substr (term', a, b) ->
      Format.fprintf ppf "(str.substr %a %a %a)" pp_term term' pp_term a pp_term b
    | At (term', a) -> Format.fprintf ppf "(str.at %a %a)" pp_term term' pp_term a
  ;;

  let proof_for_eq (type a b) : (a, b) Eq.t -> (a term, b term) Eq.t =
    fun proof ->
    match proof with
    | Eq -> Eq
  ;;

  let typeof : 'a. 'a term -> 'a kind =
    fun (type ty) (e : ty term) : ty kind ->
    match e with
    | Atom (Var (_, I)) -> I
    | Add _ -> I
    | Const _ -> I
    | Len _ -> I
    | Len2 _ -> I
    | Mul _ -> I
    | Mod _ -> I
    | Bwand _ -> I
    | Bwor _ -> I
    | Bwxor _ -> I
    | Pow _ -> I
    | Iofs _ -> I
    | Str_const _ -> S
    | Sofi _ -> S
    | Atom (Var (_, S)) -> S
    | Concat _ -> S
    | At _ -> S
    | Substr _ -> S
  ;;

  let cast_to_zterm =
    fun (type ty) (e : ty term) : (ty, Z.t) Eq.t option ->
    match typeof e with
    | I -> Some Eq.Eq
    | S -> None
  ;;

  let cast_to_sterm =
    fun (type ty) (e : ty term) : (ty, string) Eq.t option ->
    match typeof e with
    | S -> Some Eq.Eq
    | I -> None
  [@@ocaml.warnerror "-8"]
  ;;

  let disambiguate =
    fun (type ty) (e : ty term) fs fz ->
    match e with
    | Atom (Var (n, S)) as v -> fs v
    | Str_const _ as v -> fs v
    | Sofi _ as v -> fs v
    | Concat _ as v -> fs v
    | At _ as v -> fs v
    | Substr _ as v -> fs v
    | Atom (Var (n, I)) as v -> fz v
    | Const _ as v -> fz v
    | Iofs _ as v -> fz v
    | Len _ as v -> fz v
    | Len2 _ as v -> fz v
    | Add _ as v -> fz v
    | Mul _ as v -> fz v
    | Mod _ as v -> fz v
    | Pow _ as v -> fz v
    | Bwand _ as v -> fz v
    | Bwor _ as v -> fz v
    | Bwxor _ as v -> fz v
  ;;

  let match_typ fs fz (type a) : a term -> _ = function
    | ( Const _ | Len _
      | Atom (Var (_, I))
      | Add _ | Mul _ | Mod _ | Bwand _ | Bwor _ | Bwxor _ | Pow _ | Iofs _ | Len2 _ ) as
      ast -> fz ast
    | (Str_const _ | Atom (Var (_, S)) | Sofi _ | Concat _ | At _ | Substr _) as ast ->
      fs ast
  ;;

  let is_constant_term =
    let exception Early of Z.t in
    let rec helper = function
      | Atom (Var _) -> None
      | Const n -> Some n
      | Add ts ->
        (try
           List.fold_left
             (fun acc x ->
                match helper x with
                | None -> None
                | Some m -> Option.map (Z.( + ) m) acc)
             (Some Z.zero)
             ts
         with
         | Early n -> Some n)
      | Mul ts ->
        (try
           List.fold_left
             (fun acc x ->
                match helper x with
                | None -> None
                | Some m when Z.(m = zero) -> raise (Early Z.zero)
                | Some m -> Option.map (Z.( * ) m) acc)
             (Some Z.one)
             ts
         with
         | Early n -> Some n)
      | _ -> None
    in
    helper
  ;;

  (* let%test _ = is_constant_term (atom (const (Z.of_int 4))) = Some (Z.of_int 4)
  let%test _ = is_constant_term (atom (var "s")) = None

  let%test _ =
    is_constant_term (mul [ atom (const (Z.of_int 4)); atom (const Z.one) ])
    = Some (Z.of_int 4)
  ;;

  let%test _ =
    is_constant_term (add [ atom (const (Z.of_int 4)); atom (const Z.one) ])
    = Some (Z.of_int 5)
  ;; *)

  let rec map_term
    : 'a 'b. (Z.t term -> Z.t term) -> (string term -> string term) -> 'a term -> 'a term
    =
    fun (type a)
      (fz : Z.t term -> Z.t term)
      (fs : string term -> string term)
      : (a term -> a term) ->
      function
    | Len x -> fz (Len x)
    | Const c -> fz (Const c)
    | Str_const s -> fs (Str_const s)
    | Atom (Var (name, S)) -> fs (Atom (Var (name, S)))
    | Atom (Var (name, I)) -> fz (Atom (Var (name, I)))
    | Add xs -> fz (Add (List.map (map_term fz fs) xs))
    | Mul xs -> fz (Mul (List.map (map_term fz fs) xs))
    | Mod (xs, d) -> fz (Mod (map_term fz fs xs, d))
    | Bwand (l, r) -> fz (Bwand (map_term fz fs l, map_term fz fs r))
    | Bwor (l, r) -> fz (Bwor (map_term fz fs l, map_term fz fs r))
    | Bwxor (l, r) -> fz (Bwxor (map_term fz fs l, map_term fz fs r))
    | Pow (l, r) -> fz (Pow (map_term fz fs l, map_term fz fs r))
    | Sofi s -> fs (Sofi (map_term fz fs s))
    | Iofs s -> fz (Iofs (map_term fz fs s))
    | Len2 s -> fz (Len2 (map_term fz fs s))
    | Concat (l, r) -> fs (Concat (map_term fz fs l, map_term fz fs r))
    | At (l, r) -> fs (At (map_term fz fs l, map_term fz fs r))
    | Substr (l, r, k) ->
      fs (Substr (map_term fz fs l, map_term fz fs r, map_term fz fs k))
  ;;

  (* | (Len _ | Iofs _ | Len2 _) as term -> f term *)
  (* | _ -> assert false *)

  (* | Atom _ | Len _ | Sofi _ | Iofs _ | Len2 _ -> f term
    | Add terms -> f (add (List.map (map_term f) terms))
    | Mul terms -> f (mul (List.map (map_term f) terms))
    | Bwand (term, term') -> f (bwand (map_term f term) (map_term f term'))
    | Bwor (term, term') -> f (bwor (map_term f term) (map_term f term'))
    | Bwxor (term, term') -> f (bwxor (map_term f term) (map_term f term'))
    | Pow (term, term') -> f (pow (map_term f term) (map_term f term'))
    | Mod (t, c) -> f (mod_ (map_term f t) c)
    | Concat (lhs, rhs) -> f (concat (map_term f lhs) (map_term f rhs))
    | Substr (term', a, b) -> f (substr (map_term f term') a b)
    | At (term', a) -> f (at (map_term f term') a) *)

  let rec fold_term
    :  'acc 'a.
       ('acc -> Z.t term -> 'acc)
    -> ('acc -> string term -> 'acc)
    -> 'acc
    -> 'a term
    -> 'acc
    =
    (* TODO(Kakadu): A toplevel mapper f was here that was applied to the whole term after folding.
    It is removed, I don't know was it really neeeded *)
    fun fz fs acc (type a) (term : a term) ->
    match term with
    | (Const _ | Atom (Var (_, I))) as term -> fz acc term
    | (Str_const _ | Atom (Var (_, S))) as term -> fs acc term
    | (Iofs ts | Len ts | Len2 ts) as term -> fz (fold_term fz fs acc ts) term
    | Sofi t as term -> fs (fold_term fz fs acc t) term
    | Concat (lhs, rhs) -> fold_term fz fs (fold_term fz fs acc lhs) rhs
    | Substr (term', tz1, tz2) as term ->
      fs (fold_term fz fs (fold_term fz fs (fold_term fz fs acc term') tz1) tz2) term
    | At (term', tidx) as term ->
      fs (fold_term fz fs (fold_term fz fs acc term') tidx) term
    | (Add terms | Mul terms) as term ->
      fz (List.fold_left (fold_term fz fs) acc terms) term
    | ( Bwand (term', term'')
      | Bwor (term', term'')
      | Bwxor (term', term'')
      | Pow (term', term'') ) as term ->
      fz (fold_term fz fs (fold_term fz fs acc term') term'') term
    | Mod (t, _) as term -> fz (fold_term fz fs acc t) term
  ;;

  let rec fold_term_skip_pow =
    fun fz acc (type a) (term : a term) ->
    match term with
    | (Const _ | Atom (Var (_, I))) as term -> fz acc term
    | (Add terms | Mul terms) as term ->
      fz (List.fold_left (fold_term_skip_pow fz) acc terms) term
    | (Bwand (term', term'') | Bwor (term', term'') | Bwxor (term', term'')) as term ->
      fz (fold_term_skip_pow fz (fold_term_skip_pow fz acc term') term'') term
    | Mod (t, _) as term -> fz (fold_term_skip_pow fz acc t) term
    | Pow (_, _) -> acc
    | term -> acc
  ;;

  let compare_term (type a) : a term -> a term -> int = fun l r -> Stdlib.compare l r
  (*match l, r with
    | _ -> failwith "tbd"*)

  type t =
    | Eq : 'a term * 'a term * 'a kind -> t
    | Leq : Z.t term * Z.t term -> t
    | InRe : 'a term * 'a kind * char list Regex.t -> t
    | InReRaw : 'a term * 'a kind * NfaS.t -> t
    | RLen : Z.t term * Z.t term -> t
    | PrefixOf of string term * string term
    | Contains of string term * string term
    | SuffixOf of string term * string term
  [@@deriving variants]

  let compare l r = Stdlib.compare l r
  let geq a b = leq b a
  let lt a b = leq (add [ a; const Z.one ]) b
  let gt a b = lt b a

  let map f = function
    | Eq _ as eia -> f eia
    | Leq _ as eia -> f eia
    | InRe _ as eia -> f eia
    | InReRaw _ as eia -> f eia
    | RLen _ as eia -> f eia
    | PrefixOf _ as eia -> f eia
    | SuffixOf _ as eia -> f eia
    | Contains _ as eia -> f eia
  ;;

  let map2 f fint fstring = function
    | Eq (term, term', I) ->
      f (Eq (map_term fint fstring term, map_term fint fstring term', I))
    | Eq (l, r, S) -> f (Eq (map_term fint fstring l, map_term fint fstring r, S))
    | Leq (term, term') ->
      f (leq (map_term fint fstring term) (map_term fint fstring term'))
    | RLen (v, pow) -> f (rlen (map_term fint fstring v) (map_term fint fstring pow))
    | InRe (term, kind, re) -> f (inre (map_term fint fstring term) kind re)
    | InReRaw (term, kind, re) -> f (inreraw (map_term fint fstring term) kind re)
    | PrefixOf (term, term') ->
      f (prefixof (map_term fint fstring term) (map_term fint fstring term'))
    | SuffixOf (term, term') ->
      f (suffixof (map_term fint fstring term) (map_term fint fstring term'))
    | Contains (term, term') ->
      f (contains (map_term fint fstring term) (map_term fint fstring term'))
  ;;

  let fold2 fz fs acc : t -> _ =
    let _ : 'acc -> Z.t term -> 'acc = fz in
    let _ : 'acc -> string term -> 'acc = fs in
    function
    | Eq (l, r, I) -> fold_term fz fs (fold_term fz fs acc l) r
    | Eq (l, r, S) -> fold_term fz fs (fold_term fz fs acc l) r
    | Leq (term, term') -> fold_term fz fs (fold_term fz fs acc term) term'
    | RLen (v, pow) -> fold_term fz fs (fold_term fz fs acc v) pow
    | InRe (term, _, re) -> fold_term fz fs acc term
    | InReRaw (term, _, re) -> fold_term fz fs acc term
    | PrefixOf (term, term') | Contains (term, term') | SuffixOf (term, term') ->
      fold_term fz fs (fold_term fz fs acc term) term'
  ;;

  let fold2_skip_pow fz acc : t -> _ =
    let _ : 'acc -> Z.t term -> 'acc = fz in
    function
    | Eq (l, r, I) -> fold_term_skip_pow fz (fold_term_skip_pow fz acc l) r
    | Leq (term, term') -> fold_term_skip_pow fz (fold_term_skip_pow fz acc term) term'
    | RLen (v, pow) -> fold_term_skip_pow fz (fold_term_skip_pow fz acc v) pow
    | InRe (term, I, re) -> fold_term_skip_pow fz acc term
    | InReRaw (term, I, re) -> fold_term_skip_pow fz acc term
    | _ -> acc
  ;;

  let pp fmt = function
    | Eq (term, term', _) -> Format.fprintf fmt "@[(= %a %a)@]" pp_term term pp_term term'
    | Leq (term, term') -> Format.fprintf fmt "@[(<= %a %a)@]" pp_term term pp_term term'
    | InRe (str, _, re) ->
      Format.fprintf
        fmt
        "(str.in_re %a %a)"
        pp_term
        str
        (Regex.pp (fun ppf a -> Format.fprintf fmt "%s" (List.to_seq a |> String.of_seq)))
        re
    | InReRaw (str, _, _) -> Format.fprintf fmt "(str.in_re.raw %a)" pp_term str
    | RLen (v, pow) -> Format.fprintf fmt "(chrob.len %a %a)" pp_term v pp_term pow
    (* | Eq (re, re') -> Format.fprintf fmt "(= %a %a)" pp_term re pp_term re' *)
    | PrefixOf (term, term') ->
      Format.fprintf fmt "(str.prefixof %a %a)" pp_term term pp_term term'
    | Contains (term, term') ->
      Format.fprintf fmt "(str.contains %a %a)" pp_term term pp_term term'
    | SuffixOf (term, term') ->
      Format.fprintf fmt "(str.suffixof %a %a)" pp_term term pp_term term'
  ;;

  let equal = Stdlib.( = )
  let eq_term : 'a term -> 'a term -> bool = Stdlib.( = )
end

type typed_term = TT : 'a kind * 'a Eia.term -> typed_term

type t =
  | True
  | Eia of Eia.t
  | Lnot of t
  | Land of t list
  | Lor of t list
  | Exists of any_atom list * t
  | Pred of string
  | Unsupp of string
[@@deriving compare]

let true_ = True

let land_ = function
  | [] -> true_
  | [ ast ] -> ast
  | asts when List.exists (( = ) (Lnot True)) asts -> Lnot True
  | asts ->
    let asts =
      List.concat_map
        (function
          | Land asts' -> asts'
          | ast -> [ ast ])
        asts
    in
    Land asts
;;

let lor_ = function
  | [] -> true_
  | [ ast ] -> ast
  | asts when List.exists (( = ) True) asts -> True
  | asts ->
    let asts =
      List.map
        (function
          | Lor asts' -> asts'
          | ast -> [ ast ])
        asts
      |> List.concat
    in
    Lor asts
;;

let eia eia = Eia eia
let pred s = Pred s

let rec lnot = function
  | Lnot ast -> ast
  | Land asts -> lor_ (List.map lnot asts)
  | Lor asts -> land_ (List.map lnot asts)
  | ast -> Lnot ast
;;

let rec exists = function
  | [] -> Fun.id
  | atoms -> begin
    function
    | Exists (atoms', ast) -> exists (atoms @ atoms') ast
    | ast -> Exists (atoms, ast)
  end
;;

let limpl a b = lor_ [ lnot a; b ]
let any atoms ast = lnot (exists atoms (lnot ast))
let false_ = lnot true_

let rec pp ppf = function
  | True -> Format.fprintf ppf "True"
  | Pred a -> Format.fprintf ppf "(P %s)" a
  | Lnot a -> Format.fprintf ppf "(~ %a)" pp a
  | Land irs ->
    Format.fprintf
      ppf
      "(%a)"
      (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt " & ") pp)
      irs
  | Lor irs ->
    Format.fprintf
      ppf
      "(%a)"
      (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt " | ") pp)
      irs
  | Exists (a, b) ->
    Format.fprintf
      ppf
      "(E%a %a)"
      (Format.pp_print_list ~pp_sep:(fun ppf () -> Format.fprintf ppf " ") pp_any_atom)
      a
      pp
      b
  | Eia eia -> Format.fprintf ppf "%a" Eia.pp eia
  | Unsupp s -> Format.fprintf ppf "%s" s
;;

let pp_smtlib2 =
  let open Format in
  let rec pp ppf = function
    | True -> Format.fprintf ppf "True"
    | Pred a -> Format.fprintf ppf "(P %s)" a
    | Lnot a -> Format.fprintf ppf "(not %a)" pp a
    | Land irs ->
      Format.fprintf ppf "@[<v 2>(and@,";
      List.iteri
        (fun i ->
           if i <> 0 then fprintf ppf "@,";
           fprintf ppf "@[%a@]" pp)
        irs;
      fprintf ppf ")@]"
    | Lor irs ->
      Format.fprintf
        ppf
        "(%a)"
        (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt " | ") pp)
        irs
    | Exists (a, b) ->
      Format.fprintf
        ppf
        "(exists (%a) %a)"
        (Format.pp_print_list ~pp_sep:(fun ppf () -> Format.fprintf ppf " ") pp_any_atom)
        a
        pp
        b
    | Eia eia -> fprintf ppf "%a" Eia.pp eia
    | Unsupp s -> fprintf ppf "%s" s
  in
  pp
;;

let pp_term_smtlib2 =
  let open Format in
  let rec pp_eia : 'a. _ -> 'a Eia.term -> unit =
    fun ppf (type a) : (a Eia.term -> unit) -> function
      | Eia.(Const c) when Z.lt c Z.zero -> fprintf ppf "(- %a)" Z.pp_print (Z.( ~- ) c)
      | Atom a -> fprintf ppf "%a" pp_atom a
      | Add xs ->
        fprintf ppf "@[(+ %a)@]" (pp_print_list pp_eia ~pp_sep:pp_print_space) xs
      | Mul [ Const c; (Atom (Var _) as v) ] when Z.(equal c minus_one) ->
        fprintf ppf "@[(- %a)@]" pp_eia v
      | Mul xs ->
        fprintf ppf "@[(* %a)@]" (pp_print_list pp_eia ~pp_sep:pp_print_space) xs
      | Pow (base, p) -> fprintf ppf "(exp %a %a)" pp_eia base pp_eia p
      | x -> Eia.pp_term ppf x
  in
  pp_eia
;;

(*
   let tfold ft acc t =
  let rec foldt acc = function
    | (Const _ | Var _) as f -> ft acc f
    | (Pow (_, t1) | Mul (_, t1)) as t -> ft (foldt acc t1) t
    | (Add (t1, t2) | Bvand (t1, t2) | Bvor (t1, t2) | Bvxor (t1, t2)) as t ->
      ft (foldt (foldt acc t1) t2) t
  in
  foldt acc t
;;

let fold ff ft acc f =
  let rec foldt acc = function
    | (Const _ | Var _) as f -> ft acc f
    | (Pow (_, t1) | Mul (_, t1)) as t -> ft (foldt acc t1) t
    | (Add (t1, t2) | Bvand (t1, t2) | Bvor (t1, t2) | Bvxor (t1, t2)) as t ->
      ft (foldt (foldt acc t1) t2) t
  in
  let rec foldf acc = function
    | (True | False) as f -> ff acc f
    | ( Eq (t1, t2)
      | Lt (t1, t2)
      | Gt (t1, t2)
      | Leq (t1, t2)
      | Geq (t1, t2)
      | Neq (t1, t2) ) as f -> ff (foldt (foldt acc t1) t2) f
    | (Mor (f1, f2) | Mand (f1, f2) | Miff (f1, f2) | Mimpl (f1, f2)) as f ->
      ff (foldf (foldf acc f1) f2) f
    | Mnot f1 as f -> ff (foldf acc f1) f
    | (Exists (_, f1) | Any (_, f1)) as f -> ff (foldf acc f1) f
    | Pred (_, args) as f -> ff (List.fold_left foldt acc args) f
  in
  foldf acc f
;;

let for_some ff ft f =
  fold (fun acc f -> ff f |> ( || ) acc) (fun acc t -> ft t |> ( || ) acc) false f
;;


let for_all ff ft f =
  fold (fun acc f -> ff f |> ( && ) acc) (fun acc t -> ft t |> ( && ) acc) true f
;;


let map ff ft f =
  let rec mapt = function
    | (Const _ | Var _) as f -> ft f
    | Mul (a, t1) -> Mul (a, mapt t1) |> ft
    | Add (t1, t2) -> Add (mapt t1, mapt t2) |> ft
    | Bvand (t1, t2) -> Bvand (mapt t1, mapt t2) |> ft
    | Bvor (t1, t2) -> Bvor (mapt t1, mapt t2) |> ft
    | Bvxor (t1, t2) -> Bvxor (mapt t1, mapt t2) |> ft
    | Pow (a, t1) -> Pow (a, mapt t1) |> ft
  in
  mapf f
;;
*)

let rec fold f acc ast =
  match ast with
  | True -> f acc ast
  | Eia _ -> f acc ast
  | Lnot ast' -> f (fold f acc ast') ast
  | Land asts -> f (List.fold_left (fold f) acc asts) ast
  | Lor asts -> f (List.fold_left (fold f) acc asts) ast
  | Exists (_, ast') -> f (fold f acc ast') ast
  | Pred _ -> f acc ast
  | Unsupp s -> acc
;;

let forall f = fold (fun acc ast -> acc && f ast) true
let forsome f = fold (fun acc ast -> acc || f ast) false

let is_conjunct ast =
  let rec helper acc ast =
    match ast with
    | True | Eia _ | Pred _ | Unsupp _
    | Lnot True
    | Lnot (Eia _)
    | Lnot (Pred _)
    | Lnot (Unsupp _) -> true
    | Exists (_, ast') -> helper acc ast'
    | Land asts -> List.fold_left (fun acc ast -> acc && helper acc ast) acc asts
    | _ -> false
  in
  helper true ast
;;

let rec to_dnf ast =
  let cartesian l1 l2 =
    List.concat (List.map (fun e1 -> List.map (fun e2 -> land_ [ e1; e2 ]) l2) l1)
  in
  if is_conjunct ast
  then [ ast ]
  else (
    match ast with
    | Land [ x ] -> to_dnf x
    | Land (x :: xs) -> List.fold_left cartesian (to_dnf x) (List.map to_dnf xs)
    | Lor xs -> List.concat (List.map to_dnf xs)
    | other -> [ other ])
;;

let rec in_eia_term f v ast =
  match ast with
  | True | Pred _ -> false
  | Eia eia -> f v eia
  | Lnot ast' | Exists (_, ast') -> in_eia_term f v ast'
  | Land asts | Lor asts ->
    List.fold_left (fun acc ast -> acc || in_eia_term f v ast) false asts
  | Unsupp _ -> false
;;

let in_stoi v ast =
  let in_stoi_eia v eia =
    Eia.fold2
      (fun acc el ->
         match el with
         | Eia.Iofs (Eia.Atom (Var (s, S))) when s = v -> true
         | _ -> acc)
      (fun acc _ -> acc)
      false
      eia
  in
  in_eia_term in_stoi_eia v ast
;;

let in_concat v ast =
  in_eia_term
    (fun v eia ->
       Eia.fold2
         (fun acc el ->
            match el with
            | Eia.Concat (_, Eia.Atom (Var (s, S))) when s = v -> true
            | Eia.Concat (Eia.Atom (Var (s, S)), _) when s = v -> true
            | _ -> acc)
         (fun acc _ -> acc)
         false
         eia)
    v
    ast
;;

let collect_lin_exp ast =
  let module Set = Base.Set.Poly in
  fold
    (fun (lin, exp) ast ->
       let open Eia in
       match ast with
       | Eia eia ->
         (match eia with
          | Eq (Atom (Var (x, I)), Const _, I) -> Set.add lin x, exp
          | Eq (Const _, Atom (Var (x, I)), I) -> Set.add lin x, exp
          | Eq (Add [ Const _; Atom (Var (x, I)) ], Atom (Var (_, I)), I) ->
            Set.add lin x, exp
          | Eq (Pow (_, Atom (Var (x, I))), Const _, I) -> lin, Set.add exp x
          | Eq (Mul [ Const _; Pow (_, Atom (Var (x, I))) ], Const _, I) ->
            lin, Set.add exp x
          | Leq (Atom (Var (x, I)), Const _) -> Set.add lin x, exp
          | Leq (Const _, Atom (Var (x, I))) -> Set.add lin x, exp
          | Leq (Add [ Const _; Atom (Var (x, I)) ], Atom (Var (_, I))) ->
            Set.add lin x, exp
          | Leq (Pow (_, Atom (Var (x, I))), Const _) -> lin, Set.add exp x
          | Leq (Const _, Pow (_, Atom (Var (x, I)))) -> lin, Set.add exp x
          | Leq (Mul [ Const _; Pow (_, Atom (Var (x, I))) ], Const _) ->
            lin, Set.add exp x
          | _ -> lin, exp)
       | _ -> lin, exp)
    (Set.empty, Set.empty)
    ast
;;

let collect_lin ast =
  let module Set = Base.Set.Poly in
  fold
    (fun acc ast ->
       match ast with
       | Eia eia ->
         Eia.fold2_skip_pow
           (fun acc -> function
              | Atom (Var (x, I)) -> Set.add acc x
              | _ -> acc)
           acc
           eia
       | _ -> acc)
    Set.empty
    ast
;;

(* failwith "unable to fold; unsupported constraint" *)

let rec map f = function
  | True as ast -> f ast
  | Eia _ as ast -> f ast
  | Lnot ast -> f (lnot (map f ast))
  | Land asts -> f (land_ (List.map (map f) asts))
  | Lor asts -> f (lor_ (List.map (map f) asts))
  | Exists (atoms, ast) -> f (exists atoms (map f ast))
  | Pred _ as ast -> f ast
  | Unsupp x -> Unsupp x
;;

(* failwith "unable to map; unsupported constraint" *)

let rec equal ast ast' =
  match ast, ast' with
  | True, True -> true
  | Lnot ast, Lnot ast' -> equal ast ast'
  | Land asts, Land asts' -> List.for_all2 equal asts asts'
  | Lor asts, Lor asts' -> List.for_all2 equal asts asts'
  | Exists (atoms, ast), Exists (atoms', ast') -> equal ast ast' && atoms = atoms'
  | Pred name, Pred name' -> name = name'
  | Eia eia, Eia eia' -> Eia.equal eia eia'
  | _, _ -> false
;;

let safe_eq ast ast' =
  match ast, ast' with
  | Eia (Eia.InReRaw (atom, S, lhs)), Eia (Eia.InReRaw (atom', S, rhs)) ->
    NfaS.equal_start_and_final lhs rhs && atom = atom'
  | Eia (Eia.InReRaw (atom, I, lhs)), Eia (Eia.InReRaw (atom', I, rhs)) ->
    NfaS.equal_start_and_final lhs rhs && atom = atom'
  | smth ->
    (match Stdlib.(ast = ast') with
     | exception _ -> true
     | smth -> smth)
;;

let to_nat ast =
  let module Set = Base.Set.Poly in
  let nat_prefixes =
    [ "%r"
    ; "%under2"
    ; "%subst"
    ; "%concat"
    ; "%arith_flat"
    ; "%arith_re"
    ; "%arith_re_raw"
    ; "%re_len"
    ; "strlen"
    ; "string"
    ]
  in
  let is_nat v =
    List.fold_left
      (fun acc pref -> acc || String.starts_with ~prefix:pref v)
      false
      nat_prefixes
  in
  let collect =
    fold
      (fun (acc_plus, acc_minus) -> function
         | Eia (RLen (Eia.Atom (Var (v, I)), _)) -> acc_plus, Set.add acc_minus v
         | Eia (InReRaw (Eia.Atom (Var (v, I)), _, _)) -> acc_plus, Set.add acc_minus v
         | Eia eia' ->
           Eia.fold2
             (fun (acc_plus, acc_minus) -> function
                | Eia.Atom (Var (v, I)) when not (is_nat v) ->
                  Set.add acc_plus v, acc_minus
                | eia' -> acc_plus, acc_minus)
             (fun acc _ -> acc)
             (acc_plus, acc_minus)
             eia'
         | Lor _ -> failwith "to_nat expected conjunct"
         | ast -> acc_plus, acc_minus)
      (Set.empty, Set.empty)
  in
  let vary var ast =
    [ ast
    ; map
        (function
          | Eia eia' ->
            eia
              (Eia.map2
                 Fun.id
                 (function
                   | Eia.Pow (Eia.Const base, Eia.Atom (Var (v, I))) when v = var ->
                     Eia.const Z.zero
                   | Eia.Atom (Var (v, I)) as v' when v = var ->
                     Eia.Add
                       [ Eia.Mul [ v'; Eia.const Z.minus_one ]; Eia.const Z.minus_one ]
                   | eia' -> eia')
                 Fun.id
                 eia')
          | Lor _ -> failwith "to_nat expected conjunct"
          | ast -> ast)
        ast
    ]
  in
  let vars = collect ast |> (fun x -> Set.diff (fst x) (snd x)) |> Set.to_list in
  let open Base.List.Let_syntax in
  let ( let* ) = Base.List.Let_syntax.( >>= ) in
  List.fold_left
    (fun acc var ->
       let* acc = acc in
       let* ast = vary var acc in
       return ast)
    (return ast)
    vars
;;
