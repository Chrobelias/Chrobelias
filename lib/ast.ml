(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

type atom =
  | Var of string
  | Const of int
[@@deriving variants]

let pp_atom ppf = function
  | Var n -> Format.fprintf ppf "%s" n
  | Const n -> Format.fprintf ppf "%d" n
;;

(** Exponential integer arithmetic, i.e. LIA with exponents.*)
module Eia = struct
  type term =
    | Atom of atom
    | Add of term list
    | Mul of term list
    | Bwand of term * term
    | Bwor of term * term
    | Bwxor of term * term
    | Pow of term * term
  [@@deriving variants]

  let rec map_term f = function
    | Atom _ as term -> f term
    | Add terms -> f (add (List.map (map_term f) terms))
    | Mul terms -> f (mul (List.map (map_term f) terms))
    | Bwand (term, term') -> f (bwand (map_term f term) (map_term f term'))
    | Bwor (term, term') -> f (bwor (map_term f term) (map_term f term'))
    | Bwxor (term, term') -> f (bwxor (map_term f term) (map_term f term'))
    | Pow (term, term') -> f (pow (map_term f term) (map_term f term'))
  ;;

  let rec fold_term f acc term =
    match term with
    | Atom _ -> f acc term
    | Add terms | Mul terms -> f (List.fold_left (fold_term f) acc terms) term
    | Bwand (term', term'')
    | Bwor (term', term'')
    | Bwxor (term', term'')
    | Pow (term', term'') -> f (fold_term f (fold_term f acc term') term'') term
  ;;

  let rec pp_term ppf = function
    | Atom atom -> Format.fprintf ppf "%a" pp_atom atom
    | Add terms ->
      Format.fprintf
        ppf
        "(+ %a)"
        (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt " + ") pp_term)
        terms
    | Mul terms ->
      Format.fprintf
        ppf
        "(* %a)"
        (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt " * ") pp_term)
        terms
    | Bwor (a, b) -> Format.fprintf ppf "(%a | %a)" pp_term a pp_term b
    | Bwxor (a, b) -> Format.fprintf ppf "(%a ^ %a)" pp_term a pp_term b
    | Bwand (a, b) -> Format.fprintf ppf "(%a & %a)" pp_term a pp_term b
    | Pow (a, b) -> Format.fprintf ppf "(%a ** %a)" pp_term a pp_term b
  ;;

  type t =
    | Eq of term * term
    | Leq of term * term
  [@@deriving variants (* , show *)]

  let geq a b = leq b a
  let lt a b = leq (add [ a; atom (const 1) ]) b
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
    | Eq (term, term') -> Format.fprintf fmt "%a = %a" pp_term term pp_term term'
    | Leq (term, term') -> Format.fprintf fmt "%a <= %a" pp_term term pp_term term'
  ;;

  let equal eia eia' =
    match eia, eia' with
    | Eq (term, term'), Eq (term'', term''') | Leq (term, term'), Leq (term'', term''') ->
      term = term'' && term' = term'''
    | _ -> false
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
  | Lnot of t
  | Land of t list
  | Lor of t list
  | Exists of atom list * t
  | Pred of string
[@@deriving variants]

let limpl a b = lor_ [ lnot a; b ]
let any atoms ast = lnot (exists atoms (lnot ast))

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
  | Lnot ast -> f (fold f acc ast) ast
  | Land asts -> f (List.fold_left (fold f) acc asts) ast
  | Lor asts -> f (List.fold_left (fold f) acc asts) ast
  | Exists (_, ast) -> f (fold f acc ast) ast
  | Pred _ -> f acc ast
;;

let forall f = fold (fun acc ast -> acc && f ast) true
let forsome f = fold (fun acc ast -> acc || f ast) false

let rec map f = function
  | True as ast -> f ast
  | Eia _ as ast -> f ast
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
  | _ -> false
;;
