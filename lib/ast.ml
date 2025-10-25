(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)
let compare_string = String.compare
let compare_int = Int.compare
let compare_list f = Base.List.compare f
let compare_char = Char.compare

type atom =
  | Var of string
  (* TODO: such constants should be in the EIA theory. *)
  | Const of Z.t
  | Str_const of string
[@@deriving variants, compare]

let pp_atom ppf = function
  | Var n -> Format.fprintf ppf "%s" n
  | Const n -> Format.fprintf ppf "%a" Z.pp_print n
  | Str_const s -> Format.fprintf ppf "\"%s\"" s
;;

module Eia = struct
  (** Exponential integer arithmetic, i.e. LIA with exponents.*)

  type term =
    | Atom of atom
    | Len of term
    | Add of term list
    | Mul of term list
    | Mod of term * Z.t
    | Bwand of term * term
    | Bwor of term * term
    | Bwxor of term * term
    | Pow of term * term
    (* String stuff *)
    | Sofi of term (** String of int *)
    | Iofs of term (** Int of string *)
    | Len2 of atom
    | Concat of term * term
    | At of term * atom
    | Substr of term * atom * atom
  [@@deriving variants, compare]

  let is_constant_term =
    let exception Early of Z.t in
    let rec helper = function
      | Atom (Var _) -> None
      | Atom (Const n) -> Some n
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

  let%test _ = is_constant_term (atom (const (Z.of_int 4))) = Some (Z.of_int 4)
  let%test _ = is_constant_term (atom (var "s")) = None

  let%test _ =
    is_constant_term (mul [ atom (const (Z.of_int 4)); atom (const Z.one) ])
    = Some (Z.of_int 4)
  ;;

  let%test _ =
    is_constant_term (add [ atom (const (Z.of_int 4)); atom (const Z.one) ])
    = Some (Z.of_int 5)
  ;;

  let rec map_term f = function
    | (Atom _ | Len _ | Sofi _ | Iofs _ | Len2 _) as term -> f term
    | Add terms -> f (add (List.map (map_term f) terms))
    | Mul terms -> f (mul (List.map (map_term f) terms))
    | Bwand (term, term') -> f (bwand (map_term f term) (map_term f term'))
    | Bwor (term, term') -> f (bwor (map_term f term) (map_term f term'))
    | Bwxor (term, term') -> f (bwxor (map_term f term) (map_term f term'))
    | Pow (term, term') -> f (pow (map_term f term) (map_term f term'))
    | Mod (t, c) -> f (mod_ (map_term f t) c)
    | Concat (lhs, rhs) -> f (concat (map_term f lhs) (map_term f rhs))
    | Substr (term', a, b) -> f (substr (map_term f term') a b)
    | At (term', a) -> f (at (map_term f term') a)
  ;;

  let rec fold_term f acc term =
    match term with
    | Atom _ | Len _ | Sofi _ | Len2 _ -> f acc term
    | Iofs _ -> f acc term
    | Add terms | Mul terms -> f (List.fold_left (fold_term f) acc terms) term
    | Bwand (term', term'')
    | Bwor (term', term'')
    | Bwxor (term', term'')
    | Pow (term', term'') -> f (fold_term f (fold_term f acc term') term'') term
    | Mod (t, _) -> f (fold_term f acc t) term
    | Concat (lhs, rhs) as term -> f (fold_term f (fold_term f acc lhs) rhs) term
    | Substr (term', _, _) as term -> f (fold_term f acc term') term
    | At (term', _) as term -> f (fold_term f acc term') term
  ;;

  let rec pp_term ppf = function
    | Atom (Const c) when Z.lt c Z.zero ->
      Format.fprintf ppf "(- %a)" Z.pp_print (Z.( ~- ) c)
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
    | Len2 a -> Format.fprintf ppf "@[(chrob.len %a)@]" pp_atom a
    | Mod (t, z) -> Format.fprintf ppf "(mod %a %a)" pp_term t Z.pp_print z
    (* Strings  *)
    | Concat (s1, s2) -> Format.fprintf ppf "@[(str.++ %a %a)@]" pp_term s1 pp_term s2
    | Substr (term', a, b) ->
      Format.fprintf ppf "(str.substr %a %a %a)" pp_term term' pp_atom a pp_atom b
    | At (term', a) -> Format.fprintf ppf "(str.at %a %a)" pp_term term' pp_atom a
  ;;

  type t =
    | Eq of term * term
    | Leq of term * term
  [@@deriving variants, compare]

  let geq a b = leq b a
  let lt a b = leq (add [ a; atom (const Z.one) ]) b
  let gt a b = lt b a

  let map f = function
    | Eq _ as eia -> f eia
    | Leq _ as eia -> f eia
  ;;

  let map2 f fterm = function
    | Eq (term, term') -> f (eq (map_term fterm term) (map_term fterm term'))
    | Leq (term, term') -> f (leq (map_term fterm term) (map_term fterm term'))
  ;;

  let fold2 f fterm acc = function
    | (Eq (term, term') | Leq (term, term')) as ast ->
      f (fold_term fterm (fold_term fterm acc term) term') ast
  ;;

  let pp fmt = function
    | Eq (term, term') -> Format.fprintf fmt "@[(= %a %a)@]" pp_term term pp_term term'
    | Leq (term, term') -> Format.fprintf fmt "@[(<= %a %a)@]" pp_term term pp_term term'
  ;;

  let equal eia eia' =
    match eia, eia' with
    | Eq (term, term'), Eq (term'', term''') | Leq (term, term'), Leq (term'', term''') ->
      term = term'' && term' = term'''
    | _ -> false
  ;;

  let eq_term : term -> term -> bool = Stdlib.( = )
end

(** String theory. *)
module Str = struct
  type term = Eia.term [@@deriving compare]

  let pp_term = Eia.pp_term

  type t =
    | InRe of term * char list Regex.t
    | PrefixOf of term * term
    | Contains of term * term
    | SuffixOf of term * term
  [@@deriving variants, compare (* , show *)]

  let pp fmt = function
    | InRe (str, re) ->
      Format.fprintf
        fmt
        "(str.in_re %a %a)"
        Eia.pp_term
        str
        (Regex.pp (fun ppf a -> Format.fprintf fmt "%s" (List.to_seq a |> String.of_seq)))
        re
    (* | Eq (re, re') -> Format.fprintf fmt "(= %a %a)" pp_term re pp_term re' *)
    | PrefixOf (term, term') ->
      Format.fprintf fmt "(str.prefixof %a %a)" pp_term term pp_term term'
    | Contains (term, term') ->
      Format.fprintf fmt "(str.contains %a %a)" pp_term term pp_term term'
    | SuffixOf (term, term') ->
      Format.fprintf fmt "(str.suffixof %a %a)" pp_term term pp_term term'
  ;;

  let equal str str' =
    match str, str' with
    | InRe (str, re), InRe (str', re') -> str = str' && re = re'
    | PrefixOf (re, re'), PrefixOf (re'', re''')
    | SuffixOf (re, re'), SuffixOf (re'', re''')
    | Contains (re, re'), Contains (re'', re''') -> re = re'' && re' = re'''
    | _, _ -> false
  ;;

  let fold2 f fterm acc = function
    | InRe (term, re) as ast -> f (Eia.fold_term fterm acc term) ast
    | (PrefixOf (term, term') | Contains (term, term') | SuffixOf (term, term')) as ast ->
      f (Eia.fold_term fterm (Eia.fold_term fterm acc term) term') ast
  ;;
end

(** Bitvectors. *)
(*Emodule Bv = struct
  type t =
    | Atom of atom
    | And of t list
    | Or of t list
  [@@deriving variants]

  let rec pp fmt = function
    | Atom atom -> Format.fprintf fmt "%a" pp_atom atom
    | And terms ->
      Format.fprintf
        fmt
        "(%a)"
        (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt " & ") pp)
        terms
    | Or terms ->
      Format.fprintf
        fmt
        "(%a)"
        (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt " | ") pp)
        terms
  ;;

  type ir = Eq of t list [@@deriving variants]

  let pp_ir fmt = function
    | Eq terms ->
      Format.fprintf
        fmt
        "(%a)"
        (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt " = ") pp)
        terms
  ;;

  let equal = ( = )
end*)

type t =
  | True
  (*| Pred of predname * term list*)
  | Eia of Eia.t
  | Str of Str.t
  | Lnot of t
  | Land of t list
  | Lor of t list
  | Exists of atom list * t
  | Pred of string
[@@deriving variants, compare]

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
      (Format.pp_print_list ~pp_sep:(fun ppf () -> Format.fprintf ppf " ") pp_atom)
      a
      pp
      b
  | Eia eia -> Format.fprintf ppf "%a" Eia.pp eia
  | Str str -> Format.fprintf ppf "%a" Str.pp str
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
        (Format.pp_print_list ~pp_sep:(fun ppf () -> Format.fprintf ppf " ") pp_atom)
        a
        pp
        b
    | Eia eia -> fprintf ppf "%a" Eia.pp eia
    | Str s -> fprintf ppf "%a" Str.pp s
  in
  pp
;;

let pp_term_smtlib2 =
  let open Format in
  let rec pp_eia ppf = function
    | Eia.Atom (Const c) when Z.lt c Z.zero ->
      fprintf ppf "(- %a)" Z.pp_print (Z.( ~- ) c)
    | Atom a -> fprintf ppf "%a" pp_atom a
    | Add xs -> fprintf ppf "@[(+ %a)@]" (pp_print_list pp_eia ~pp_sep:pp_print_space) xs
    | Mul [ Atom (Const c); (Atom (Var _) as v) ] when Z.(equal c minus_one) ->
      fprintf ppf "@[(- %a)@]" pp_eia v
    | Mul xs -> fprintf ppf "@[(* %a)@]" (pp_print_list pp_eia ~pp_sep:pp_print_space) xs
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
  | Str _ -> f acc ast
  | Lnot ast' -> f (fold f acc ast') ast
  | Land asts -> f (List.fold_left (fold f) acc asts) ast
  | Lor asts -> f (List.fold_left (fold f) acc asts) ast
  | Exists (_, ast') -> f (fold f acc ast') ast
  | Pred _ -> f acc ast
;;

let forall f = fold (fun acc ast -> acc && f ast) true
let forsome f = fold (fun acc ast -> acc || f ast) false

let rec map f = function
  | True as ast -> f ast
  | Eia _ as ast -> f ast
  | Str _ as ast -> f ast
  | Lnot ast -> f (lnot (map f ast))
  | Land asts -> f (land_ (List.map (map f) asts))
  | Lor asts -> f (lor_ (List.map (map f) asts))
  | Exists (atoms, ast) -> f (exists atoms (map f ast))
  | Pred _ as ast -> f ast
;;

let rec equal ast ast' =
  match ast, ast' with
  | True, True -> true
  | Lnot ast, Lnot ast' -> equal ast ast'
  | Land asts, Land asts' -> List.for_all2 equal asts asts'
  | Lor asts, Lor asts' -> List.for_all2 equal asts asts'
  | Exists (atoms, ast), Exists (atoms', ast') -> equal ast ast' && atoms = atoms'
  | Pred name, Pred name' -> name = name'
  | Eia eia, Eia eia' -> Eia.equal eia eia'
  | Str str, Str str' -> Str.equal str str'
  | _ -> false
;;

let fold_term feia acc = function
  | eia -> Eia.fold_term feia acc eia
;;

let map_term feia = function
  | eia -> Eia.map_term feia eia
;;
