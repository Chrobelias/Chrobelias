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

let str_var name = Var (name, S)
let int_var name = Var (name, I)

type any_atom = Any_atom : 'a atom -> any_atom

let pp_atom ppf = function
  | Var (n, _) -> Format.fprintf ppf "%s" n
;;

let pp_any_atom ppf = function
  | Any_atom a -> Format.fprintf ppf "%a" pp_atom a
;;

(* | Const n -> Format.fprintf ppf "%a" Z.pp_print n
  | Str_const s -> Format.fprintf ppf "\"%s\"" s *)

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

  let match_typ fs fz (type a) : a term -> _ = function
    | Const z -> fz (Const z)
    | Str_const z -> fs (Str_const z)
    | _ -> failwith "Gosha, implement me"
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
    | Mul xs -> fz (Mul xs)
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

  (* let rec fold_term f acc term =
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
  ;; *)

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

  type t =
    | Eq : 'a term * 'a term -> t
    | Leq : Z.t term * Z.t term -> t
  [@@deriving variants]

  let geq a b = leq b a
  let lt a b = leq (add [ a; const Z.one ]) b
  let gt a b = lt b a

  let map f = function
    | Eq _ as eia -> f eia
    | Leq _ as eia -> f eia
  ;;

  let map2 f fint fstring = function
    | Eq (term, term') ->
      f (eq (map_term fint fstring term) (map_term fint fstring term'))
    | Leq (term, term') ->
      f (leq (map_term fint fstring term) (map_term fint fstring term'))
  ;;

  (* let fold2 f fterm acc = function
    | (Eq (term, term') | Leq (term, term')) as ast ->
      f (fold_term fterm (fold_term fterm acc term) term') ast
  ;; *)

  let pp fmt = function
    | Eq (term, term') -> Format.fprintf fmt "@[(= %a %a)@]" pp_term term pp_term term'
    | Leq (term, term') -> Format.fprintf fmt "@[(<= %a %a)@]" pp_term term pp_term term'
  ;;

  let equal = Stdlib.( = )
  let eq_term : 'a term -> 'a term -> bool = Stdlib.( = )
end

(** String theory. *)
module Str = struct
  type term = string Eia.term

  let pp_term = Eia.pp_term

  type t =
    | InRe of term * char list Regex.t
    | PrefixOf of term * term
    | Contains of term * term
    | SuffixOf of term * term
  [@@deriving variants]

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
  (*
     let fold2 f fterm acc = function
    | InRe (term, re) as ast -> f (Eia.fold_term fterm acc term) ast
    | (PrefixOf (term, term') | Contains (term, term') | SuffixOf (term, term')) as ast ->
      f (Eia.fold_term fterm (Eia.fold_term fterm acc term) term') ast
  ;; *)
end

type t =
  | True
  | Eia of Eia.t
  | Str of Str.t
  | Lnot of t
  | Land of t list
  | Lor of t list
  | Exists : any_atom list * t -> t
  | Pred of string
[@@deriving variants]

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
        (Format.pp_print_list ~pp_sep:(fun ppf () -> Format.fprintf ppf " ") pp_any_atom)
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
    | Eia.(Const c) when Z.lt c Z.zero -> fprintf ppf "(- %a)" Z.pp_print (Z.( ~- ) c)
    | Atom a -> fprintf ppf "%a" pp_atom a
    | Add xs -> fprintf ppf "@[(+ %a)@]" (pp_print_list pp_eia ~pp_sep:pp_print_space) xs
    | Mul [ Const c; (Atom (Var _) as v) ] when Z.(equal c minus_one) ->
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
(*
   let fold_term feia acc = function
  | eia -> Eia.fold_term feia acc eia
;;

let map_term feia = function
  | eia -> Eia.map_term feia eia
;; *)
