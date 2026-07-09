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

let of_lia_atom : AstL.atom -> 'a atom = function
  | Var s -> Var (s, I)
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

module RLia = struct
  (** Linear integer arithmetic with regular constraints.*)

  type 'a term =
    | Const : Z.t -> Z.t term
    | Atom : 'a atom -> 'a term
    | Add : Z.t term list -> Z.t term
    | Mul : Z.t term list -> Z.t term
    | Mod : Z.t term * Z.t -> Z.t term
    | Bwand : Z.t term * Z.t term -> Z.t term
    | Bwor : Z.t term * Z.t term -> Z.t term
    | Bwxor : Z.t term * Z.t term -> Z.t term
    (* String stuff *)
    | Str_const : string -> string term
    | Iofs : string term -> Z.t term
  [@@deriving variants]

  let rec pp_term : 'a. Format.formatter -> 'a term -> unit =
    fun (type a) ppf : (a term -> unit) -> function
    | Const c when Z.lt c Z.zero -> Format.fprintf ppf "(- %a)" Z.pp_print (Z.( ~- ) c)
    | Const c -> Z.pp_print ppf c
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
    | Bwor (a, b) -> Format.fprintf ppf "(%a | %a)" pp_term a pp_term b
    | Bwxor (a, b) -> Format.fprintf ppf "(%a ^ %a)" pp_term a pp_term b
    | Bwand (a, b) -> Format.fprintf ppf "(%a & %a)" pp_term a pp_term b
    | Mod (t, z) -> Format.fprintf ppf "(mod %a %a)" pp_term t Z.pp_print z
    (* Strings  *)
    | Str_const s -> Format.fprintf ppf "\"%s\"" s
    | Iofs s -> Format.fprintf ppf "(str.to.int %a)" pp_term s
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
    | Mul _ -> I
    | Mod _ -> I
    | Bwand _ -> I
    | Bwor _ -> I
    | Bwxor _ -> I
    | Iofs _ -> I
    | Str_const _ -> S
    | Atom (Var (_, S)) -> S
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

  let rec map_term
    : 'a 'b. (Z.t term -> Z.t term) -> (string term -> string term) -> 'a term -> 'a term
    =
    fun (type a)
      (fz : Z.t term -> Z.t term)
      (fs : string term -> string term)
      : (a term -> a term) ->
      function
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
    | Iofs s -> fz (Iofs (map_term fz fs s))
  ;;

  let rec fold_term
    :  'acc 'a.
       ('acc -> Z.t term -> 'acc)
    -> ('acc -> string term -> 'acc)
    -> 'acc
    -> 'a term
    -> 'acc
    =
    fun fz fs acc (type a) (term : a term) ->
    match term with
    | (Const _ | Atom (Var (_, I))) as term -> fz acc term
    | (Str_const _ | Atom (Var (_, S))) as term -> fs acc term
    | Iofs ts as term -> fz (fold_term fz fs acc ts) term
    | (Add terms | Mul terms) as term ->
      fz (List.fold_left (fold_term fz fs) acc terms) term
    | (Bwand (term', term'') | Bwor (term', term'') | Bwxor (term', term'')) as term ->
      fz (fold_term fz fs (fold_term fz fs acc term') term'') term
    | Mod (t, _) as term -> fz (fold_term fz fs acc t) term
  ;;

  let compare_term (type a) : a term -> a term -> int = fun l r -> Stdlib.compare l r

  let rec of_lia_term : AstL.Lia.term -> 'a term = function
    | Const c -> Const c
    | Atom (Var name) -> Atom (Var (name, I))
    | Add xs -> Add (List.map of_lia_term xs)
    | Mul xs -> Mul (List.map of_lia_term xs)
    | Mod (xs, d) -> Mod (of_lia_term xs, d)
  ;;

  type t =
    | Eq : 'a term * 'a term * 'a kind -> t
    | Neq : 'a term * 'a term * 'a kind -> t
    | Leq : Z.t term * Z.t term -> t
    | InRe : 'a term * 'a kind * char list Regex.t -> t
    | InReRaw : 'a term * 'a kind * NfaS.t -> t
    | V : Z.t term * Z.t term -> t
  [@@deriving variants]

  let compare l r = Stdlib.compare l r
  let geq a b = leq b a
  let lt a b = leq (add [ a; const Z.one ]) b
  let gt a b = lt b a

  let map f = function
    | Eq _ as rlia -> f rlia
    | Neq _ as rlia -> f rlia
    | Leq _ as rlia -> f rlia
    | InRe _ as rlia -> f rlia
    | InReRaw _ as rlia -> f rlia
    | V _ as rlia -> f rlia
  ;;

  let map2 f fint fstring = function
    | Eq (term, term', I) ->
      f (Eq (map_term fint fstring term, map_term fint fstring term', I))
    | Eq (l, r, S) -> f (Eq (map_term fint fstring l, map_term fint fstring r, S))
    | Neq (term, term', I) ->
      f (Neq (map_term fint fstring term, map_term fint fstring term', I))
    | Neq (l, r, S) -> f (Neq (map_term fint fstring l, map_term fint fstring r, S))
    | Leq (term, term') ->
      f (leq (map_term fint fstring term) (map_term fint fstring term'))
    | V (var, pow) -> f (v (map_term fint fstring var) (map_term fint fstring pow))
    | InRe (term, kind, re) -> f (inre (map_term fint fstring term) kind re)
    | InReRaw (term, kind, re) -> f (inreraw (map_term fint fstring term) kind re)
  ;;

  let fold2 fz fs acc : t -> _ =
    let _ : 'acc -> Z.t term -> 'acc = fz in
    let _ : 'acc -> string term -> 'acc = fs in
    function
    | Eq (l, r, I) -> fold_term fz fs (fold_term fz fs acc l) r
    | Eq (l, r, S) -> fold_term fz fs (fold_term fz fs acc l) r
    | Neq (l, r, I) -> fold_term fz fs (fold_term fz fs acc l) r
    | Neq (l, r, S) -> fold_term fz fs (fold_term fz fs acc l) r
    | Leq (term, term') -> fold_term fz fs (fold_term fz fs acc term) term'
    | V (var, pow) -> fold_term fz fs (fold_term fz fs acc var) pow
    | InRe (term, _, re) -> fold_term fz fs acc term
    | InReRaw (term, _, re) -> fold_term fz fs acc term
  ;;

  let pp fmt = function
    | Eq (term, term', _) -> Format.fprintf fmt "@[(= %a %a)@]" pp_term term pp_term term'
    | Neq (term, term', _) ->
      Format.fprintf fmt "@[(distinct %a %a)@]" pp_term term pp_term term'
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
    | V (var, pow) -> Format.fprintf fmt "(buchi.v %a %a)" pp_term var pp_term pow
  ;;

  let equal = Stdlib.( = )
  let eq_term : 'a term -> 'a term -> bool = Stdlib.( = )

  let of_lia : AstL.Lia.t -> t = function
    | Eq (l, r) -> Eq (of_lia_term l, of_lia_term r, I)
    | Neq (l, r) -> Neq (of_lia_term l, of_lia_term r, I)
    | Leq (l, r) -> Leq (of_lia_term l, of_lia_term r)
  ;;
end

type typed_term = TT : 'a kind * 'a RLia.term -> typed_term

type t =
  | True
  | RLia of RLia.t
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

let rlia rlia = RLia rlia
let pred s = Pred s
let get_pred ?(s = "Atom") i = Pred (Format.asprintf "%s%d" s i)

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
      (Format.pp_print_list ~pp_sep:(fun ppf () -> Format.fprintf ppf " ") pp_any_atom)
      a
      pp
      b
  | RLia rlia -> Format.fprintf ppf "%a" RLia.pp rlia
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
    | RLia rlia -> fprintf ppf "%a" RLia.pp rlia
    | Unsupp s -> fprintf ppf "%s" s
  in
  pp
;;

let pp_term_smtlib2 =
  let open Format in
  let rec pp_rlia : 'a. _ -> 'a RLia.term -> unit =
    fun ppf (type a) : (a RLia.term -> unit) -> function
      | RLia.(Const c) when Z.lt c Z.zero -> fprintf ppf "(- %a)" Z.pp_print (Z.( ~- ) c)
      | Atom a -> fprintf ppf "%a" pp_atom a
      | Add xs ->
        fprintf ppf "@[(+ %a)@]" (pp_print_list pp_rlia ~pp_sep:pp_print_space) xs
      | Mul [ Const c; (Atom (Var _) as v) ] when Z.(equal c minus_one) ->
        fprintf ppf "@[(- %a)@]" pp_rlia v
      | Mul xs ->
        fprintf ppf "@[(* %a)@]" (pp_print_list pp_rlia ~pp_sep:pp_print_space) xs
      | x -> RLia.pp_term ppf x
  in
  pp_rlia
;;

let rec fold f acc ast =
  match ast with
  | True -> f acc ast
  | RLia _ -> f acc ast
  | Lnot ast' -> f (fold f acc ast') ast
  | Land asts -> f (List.fold_left (fold f) acc asts) ast
  | Lor asts -> f (List.fold_left (fold f) acc asts) ast
  | Exists (_, ast') -> f (fold f acc ast') ast
  | Pred _ -> f acc ast
  | Unsupp _ -> f acc ast
;;

let forall f = fold (fun acc ast -> acc && f ast) true
let forsome f = fold (fun acc ast -> acc || f ast) false

let is_conjunct ast =
  let rec helper acc ast =
    match ast with
    | True | RLia _ | Pred _ | Unsupp _
    | Lnot True
    | Lnot (RLia _)
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

let rec in_rlia_term f v ast =
  match ast with
  | True | Pred _ -> false
  | RLia rlia -> f v rlia
  | Lnot ast' | Exists (_, ast') -> in_rlia_term f v ast'
  | Land asts | Lor asts ->
    List.fold_left (fun acc ast -> acc || in_rlia_term f v ast) false asts
  | Unsupp _ -> false
;;

let collect_all ast =
  let remove_dups l = l |> Base.Set.Poly.of_list |> Base.Set.Poly.to_list in
  let module Set = Base.Set.Poly in
  fold
    (fun acc ast ->
       match ast with
       | RLia rlia ->
         RLia.fold2
           (fun (str, lin) -> function
              | Atom (Var (x, I)) -> str, x :: lin
              | _ -> str, lin)
           (fun (str, lin) -> function
              | Atom (Var (x, S)) -> x :: str, lin
              | _ -> str, lin)
           acc
           rlia
       | _ -> acc)
    ([], [])
    ast
  |> fun (a, b) -> remove_dups a, remove_dups b
;;

let get_vars ast =
  let module Set = Base.Set.Poly in
  fold
    (fun acc ast ->
       match ast with
       | RLia rlia ->
         RLia.fold2
           (fun vars -> function
              | Atom (Var (x, I)) -> Set.add vars x
              | _ -> vars)
           (fun vars -> function
              | Atom (Var (x, S)) -> Set.add vars x
              | _ -> vars)
           acc
           rlia
       | _ -> acc)
    Set.empty
    ast
;;

let get_str_vars ast = ast |> collect_all |> fun (x, y) -> x
let get_int_vars ast = ast |> collect_all |> fun (x, y) -> y

let rec map f = function
  | True as ast -> f ast
  | RLia _ as ast -> f ast
  | Lnot ast -> f (lnot (map f ast))
  | Land asts -> f (land_ (List.map (map f) asts))
  | Lor asts -> f (lor_ (List.map (map f) asts))
  | Exists (atoms, ast) -> f (exists atoms (map f ast))
  | Pred _ as ast -> f ast
  | Unsupp _ as ast -> f ast
;;

let in_stoi v ast =
  let in_stoi_rlia v rlia =
    RLia.fold2
      (fun acc el ->
         match el with
         | RLia.Iofs (RLia.Atom (Var (s, _))) when s = v -> true
         | _ -> acc)
      (fun acc _ -> acc)
      false
      rlia
  in
  in_rlia_term in_stoi_rlia v ast
;;

let rec equal ast ast' =
  match ast, ast' with
  | True, True -> true
  | Lnot ast, Lnot ast' -> equal ast ast'
  | Land asts, Land asts' -> List.for_all2 equal asts asts'
  | Lor asts, Lor asts' -> List.for_all2 equal asts asts'
  | Exists (atoms, ast), Exists (atoms', ast') -> equal ast ast' && atoms = atoms'
  | Pred name, Pred name' -> name = name'
  | RLia rlia, RLia rlia' -> RLia.equal rlia rlia'
  | _, _ -> false
;;

let safe_eq ast ast' =
  match ast, ast' with
  | RLia (RLia.InReRaw (atom, S, lhs)), RLia (RLia.InReRaw (atom', S, rhs)) ->
    atom = atom'
  | RLia (RLia.InReRaw (atom, I, lhs)), RLia (RLia.InReRaw (atom', I, rhs)) ->
    atom = atom'
  | smth ->
    (match Stdlib.(ast = ast') with
     | exception _ -> true
     | smth -> smth)
;;

let rec of_astl : AstL.t -> t = function
  | True -> True
  | Lnot ast -> lnot (of_astl ast)
  | Land asts -> land_ (List.map of_astl asts)
  | Lor asts -> lor_ (List.map of_astl asts)
  | Exists (atoms, ast) ->
    let atoms' = List.map of_lia_atom atoms in
    exists (List.map (fun x -> Any_atom x) atoms') (of_astl ast)
  | Pred s -> pred s
  | Lia lia -> RLia (RLia.of_lia lia)
;;
