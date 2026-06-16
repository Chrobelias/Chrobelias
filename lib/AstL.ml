(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2026, Chrobelias. *)
module Map = Base.Map.Poly

let compare_string = String.compare
let compare_int = Int.compare
let compare_list f = Base.List.compare f
let compare_char = Char.compare

type atom = Var : string -> atom

let compare_atom l r =
  match l, r with
  | Var v1, Var v2 -> String.compare v1 v2
;;

let failf fmt = Format.kasprintf failwith fmt
let int_var name = Var name
let vars, pars = ref 0, ref 0

let gen ?(prefix = "") n =
  fun () ->
  incr n;
  Var (Printf.sprintf "%s%d" prefix !n)
;;

let genvar = gen ~prefix:"lia" vars
let get_var_name i = Format.asprintf "lia%d" i

let is_var = function
  | Var s when String.starts_with ~prefix:"lia" s -> true
  | _ -> false
;;

let genpar = gen ~prefix:"t" pars
let get_par_name i = Format.asprintf "t%d" i

let pp_atom ppf = function
  | Var n -> Format.fprintf ppf "%s" n
;;

module Lia = struct
  type term =
    | Const : Z.t -> term
    | Atom : atom -> term
    | Add : term list -> term
    | Mul : term list -> term
    | Mod : term * Z.t -> term
  [@@deriving variants]

  let rec pp_term : Format.formatter -> term -> unit =
    fun ppf : (term -> unit) -> function
    | Const c -> Format.fprintf ppf "%a" Z.pp_print c
    | Atom atom -> Format.fprintf ppf "%a" pp_atom atom
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
    | Mod (t, z) -> Format.fprintf ppf "(mod %a %a)" pp_term t Z.pp_print z
  ;;

  let rec map_term fz = function
    | Const c -> fz (Const c)
    | Atom (Var name) -> fz (Atom (Var name))
    | Add xs -> fz (Add (List.map (map_term fz) xs))
    | Mul xs -> fz (Mul (List.map (map_term fz) xs))
    | Mod (xs, d) -> fz (Mod (map_term fz xs, d))
  ;;

  let rec fold_term : 'acc 'a. ('acc -> term -> 'acc) -> 'acc -> term -> 'acc =
    fun fz acc (term : term) ->
    match term with
    | (Const _ | Atom (Var _)) as term -> fz acc term
    | (Add terms | Mul terms) as term -> fz (List.fold_left (fold_term fz) acc terms) term
    | Mod (t, _) as term -> fz (fold_term fz acc t) term
  ;;

  let compare_term : term -> term -> int = fun l r -> Stdlib.compare l r

  type t =
    | Eq : term * term -> t
    | Neq : term * term -> t
    | Leq : term * term -> t
  [@@deriving variants]

  let compare l r = Stdlib.compare l r
  let geq a b = leq b a
  let lt a b = leq (add [ a; const Z.one ]) b
  let gt a b = lt b a

  let fold2 fz acc = function
    | Eq (l, r) -> fold_term fz (fold_term fz acc l) r
    | Neq (l, r) -> fold_term fz (fold_term fz acc l) r
    | Leq (term, term') -> fold_term fz (fold_term fz acc term) term'
  ;;

  let map f = function
    | Eq _ as lia -> f lia
    | Neq _ as lia -> f lia
    | Leq _ as lia -> f lia
  ;;

  let collect_lin_exp term =
    fold_term
      (fun lin -> function
         | Atom (Var x) -> x :: lin
         | _ -> lin)
      []
      term
  ;;

  let pp fmt = function
    | Eq (term, term') -> Format.fprintf fmt "@[(= %a %a)@]" pp_term term pp_term term'
    | Neq (term, term') ->
      Format.fprintf fmt "@[(distinct %a %a)@]" pp_term term pp_term term'
    | Leq (term, term') -> Format.fprintf fmt "@[(<= %a %a)@]" pp_term term pp_term term'
  ;;

  let eq_term : term -> term -> bool = Stdlib.( = )

  let rec eq_term_alpha l r =
    match l, r with
    | Atom (Var _), Atom (Var _) -> true
    | Const c1, Const c2 -> c1 = c2
    | Add xs, Add ys | Mul xs, Mul ys ->
      List.fold_left2 (fun acc x y -> acc && eq_term_alpha x y) true xs ys
    | Mod (x, d1), Mod (y, d2) -> d1 = d2 && eq_term_alpha x y
    | other1, other2 -> eq_term other1 other2
  ;;

  let equal = Stdlib.( = )

  let equal_alpha ph1 ph2 =
    match ph1, ph2 with
    | Eq (l1, r1), Eq (l2, r2) | Neq (l1, r1), Neq (l2, r2) | Leq (l1, r1), Leq (l2, r2)
      -> eq_term_alpha l1 r1 && eq_term_alpha l2 r2
    | _ -> false
  ;;
end

type t =
  | True
  | Lia of Lia.t
  | Lnot of t
  | Land of t list
  | Lor of t list
  | Exists of atom list * t
  | Pred of string
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

let false_ = Lnot true_

let lor_ = function
  | [] -> false_
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

let lia lia = Lia lia
let pred s = Pred s
let get_pred ?(s = "Atom") i = Pred (Format.asprintf "%s_%d" s i)

let get_atom_num_exn s =
  s |> Base.String.chop_prefix_exn ~prefix:"Atom_" |> Base.Int.of_string
;;

let get_atom_numi_exn s =
  let s = s |> Base.String.chop_prefix_exn ~prefix:"Atom" in
  let s = Base.String.split s ~on:'_' in
  let nfa, s = List.nth s 0, List.nth s 1 in
  Base.Int.of_string nfa, Base.Int.of_string s
;;

let rec lnot = function
  | Lnot ast -> ast
  | Land asts -> lor_ (List.map lnot asts)
  | Lor asts -> land_ (List.map lnot asts)
  | ast -> Lnot ast
;;

let rec exists = function
  | [] -> Fun.id
  | atoms ->
    begin function
      | Exists (atoms', ast) -> exists (atoms @ atoms') ast
      | ast -> Exists (atoms, ast)
    end
;;

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
  | Lia lia -> Format.fprintf ppf "%a" Lia.pp lia
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
    | Lia lia -> fprintf ppf "%a" Lia.pp lia
  in
  pp
;;

let pp_term_smtlib2 =
  let open Format in
  let rec pp_lia : 'a. _ -> Lia.term -> unit =
    fun ppf : (Lia.term -> unit) -> function
      | Lia.(Const c) when c < Z.zero -> fprintf ppf "(- %a)" Z.pp_print c
      | Atom a -> fprintf ppf "%a" pp_atom a
      | Add xs ->
        fprintf ppf "@[(+ %a)@]" (pp_print_list pp_lia ~pp_sep:pp_print_space) xs
      | Mul [ Const c; (Atom (Var _) as v) ] when c = Z.minus_one ->
        fprintf ppf "@[(- %a)@]" pp_lia v
      | Mul xs ->
        fprintf ppf "@[(* %a)@]" (pp_print_list pp_lia ~pp_sep:pp_print_space) xs
      | x -> Lia.pp_term ppf x
  in
  pp_lia
;;

let rec fold f acc ast =
  match ast with
  | True -> f acc ast
  | Lia _ -> f acc ast
  | Lnot ast' -> f (fold f acc ast') ast
  | Land asts -> f (List.fold_left (fold f) acc asts) ast
  | Lor asts -> f (List.fold_left (fold f) acc asts) ast
  | Exists (_, ast') -> f (fold f acc ast') ast
  | Pred _ -> f acc ast
;;

let forall f = fold (fun acc ast -> acc && f ast) true
let forsome f = fold (fun acc ast -> acc || f ast) false

let is_conjunct ast =
  let rec helper acc ast =
    match ast with
    | True | Lia _ | Pred _ | Lnot True | Lnot (Lia _) | Lnot (Pred _) -> true
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

let get_vars ast =
  let remove_dups l = l |> Base.Set.Poly.of_list |> Base.Set.Poly.to_list in
  let module Set = Base.Set.Poly in
  fold
    (fun acc ast ->
       match ast with
       | Lia lia ->
         Lia.fold2
           (fun lin -> function
              | Atom (Var x) when is_var (Var x) -> x :: lin
              | _ -> lin)
           acc
           lia
       | _ -> acc)
    []
    ast
  |> remove_dups
;;

let get_val ast var =
  fold
    (fun acc -> function
       | Lia (Eq (Atom (Var v'), Const c')) when v' = get_var_name var -> c' |> Z.to_int
       | _ -> acc)
    0
    ast
;;

let project vars ast =
  let names = List.map get_var_name vars in
  let vars_to_proj = ast |> get_vars |> List.filter (fun x -> not (List.mem x names)) in
  exists (List.map (fun x -> Var x) vars_to_proj) ast
;;

let get i = Lia.Atom (Var (get_var_name i))
let get_par i = Lia.Atom (Var (get_par_name i))
let length ast = ast |> get_vars |> List.length
let get_max_digit = Lia.add [ get_par 0; Lia.const Z.minus_one ]

let rec map f = function
  | True as ast -> f ast
  | Lia _ as ast -> f ast
  | Lnot ast -> f (lnot (map f ast))
  | Land asts -> f (land_ (List.map (map f) asts))
  | Lor asts -> f (lor_ (List.map (map f) asts))
  | Exists (atoms, ast) -> f (exists atoms (map f ast))
  | Pred _ as ast -> f ast
;;

let rec equal_par eq_lia ast ast' =
  match ast, ast' with
  | True, True -> true
  | Lnot ast, Lnot ast' -> equal_par eq_lia ast ast'
  | Land asts, Land asts' | Lor asts, Lor asts' ->
    (try List.for_all2 (equal_par eq_lia) asts asts' with
     | Invalid_argument _ -> false)
  | Exists (atoms, ast), Exists (atoms', ast') ->
    equal_par eq_lia ast ast' && atoms = atoms'
  | Pred name, Pred name' -> name = name'
  | Lia lia, Lia lia' -> eq_lia lia lia'
  | _, _ -> false
;;

let equal ast ast' = equal_par Lia.equal ast ast'
let equal_alpha ast ast' = equal_par Lia.equal_alpha ast ast'

let rec is_trivial = function
  | Lia (Eq (Atom (Var _), Const _)) -> true
  | Lia (Eq (Const _, Atom (Var _))) -> true
  | Land asts -> List.fold_left (fun acc ph -> acc && is_trivial ph) true asts
  | _ -> false
;;
