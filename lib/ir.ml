module Map = Base.Map.Poly
module Set = Base.Set.Poly

(* TODO: the perfect implementation should differentiate between atoms in *)
(* different theories. But it requires a lot more complex parsing due to *)
(* the state that should be stored. So let's stick with simpler stuff now. *)
type atom =
  | Var of string
  | Internal of string
  | Pow2 of string
[@@deriving variants]

let internal () = internal (Random.int 1073741822 |> string_of_int)

let pp_atom fmt = function
  | Var var -> Format.fprintf fmt "%s" var
  | Internal var -> Format.fprintf fmt "[%s]" var
  | Pow2 var -> Format.fprintf fmt "pow2(%s)" var
;;

(* let pp_poly_atom fmt = function
  | #atom as atom -> pp_atom fmt atom
  | `Poly poly ->
    Format.fprintf
      fmt
      "(%a)"
      (Format.pp_print_list
         ~pp_sep:(fun fmt () -> Format.fprintf fmt " * ")
         (fun fmt (var, exp) -> Format.fprintf fmt "%a^%d" pp_atom var exp))
      (poly |> Map.to_alist)
;; *)

type rel =
  | Leq
  | Eq
[@@deriving variants]

let pp_rel fmt = function
  | Leq -> Format.fprintf fmt "<="
  | Eq -> Format.fprintf fmt "="
;;

type t =
  | True
  | Reg of Regex.t * atom list
  | Rel of rel * (atom, int) Map.t * int
  (* Logical operations. *)
  | Lnot of t
  | Land of t list
  | Lor of t list
  | Exists of atom list * t (*| Pred of string * 'atom Eia.t list*)
[@@deriving variants]

let false_ = lnot true_
let neg term = Map.map ~f:( ~- ) term
let eq = rel eq
let leq = rel leq
let lt t c = leq t (pred c)
let geq t c = leq (neg t) (-c)
let gt t c = leq (neg t) (pred ~-c)

(* Structural equivalence of the IR formulas. *)
let rec equal ir ir' =
  match ir, ir' with
  | True, True -> true
  | Reg (reg, atoms), Reg (reg', atoms') -> List.equal ( = ) atoms atoms' && reg = reg'
  | Rel (rel, term, c), Rel (rel', term', c') ->
    rel = rel' && c = c' && Map.equal Int.equal term term'
  | Lnot ir, Lnot ir' -> equal ir ir'
  | Land irs, Land irs' | Lor irs, Lor irs' ->
    List.length irs = List.length irs' && List.for_all2 equal irs irs'
  | Exists (atoms, ir), Exists (atoms', ir') ->
    List.equal ( = ) atoms atoms' && equal ir ir'
  | _, _ -> false
;;

module X = struct
  type t' = t
  type t = t'

  let rec equal ir ir' =
    match ir, ir' with
    | True, True -> true
    | Reg (reg, atoms), Reg (reg', atoms') -> List.equal ( = ) atoms atoms' && reg = reg'
    | Rel (rel, term, c), Rel (rel', term', c') ->
      rel = rel' && c = c' && Map.equal Int.equal term term'
    | Lnot ir, Lnot ir' -> equal ir ir'
    | Land irs, Land irs' | Lor irs, Lor irs' -> List.for_all2 equal irs irs'
    | Exists (atoms, ir), Exists (atoms', ir') ->
      Set.equal (Set.of_list atoms) (Set.of_list atoms') && equal ir ir'
    | _, _ -> false
  ;;

  let rec hash ir =
    let hashl hash l = List.fold_left (fun acc el -> acc + hash el) 0 l in
    match ir with
    | True as ir -> Hashtbl.hash ir
    | Lnot ir -> hash ir * 2
    | Land irs | Lor irs -> hashl hash irs
    | Exists (atoms, ir) -> hashl Hashtbl.hash atoms + hash ir
    | Rel (rel, term, c) ->
      Hashtbl.hash c + Hashtbl.hash rel + (Map.data term |> List.fold_left ( + ) 0)
    | Reg (regex, atoms) -> Hashtbl.hash regex + hashl Hashtbl.hash atoms
  ;;
end

let rec pp fmt = function
  | True -> Format.fprintf fmt "true"
  | Rel (rel, term, c) ->
    Format.fprintf
      fmt
      "(%a %a %d)"
      (Format.pp_print_list
         ~pp_sep:(fun fmt () -> Format.fprintf fmt " + ")
         (fun fmt (a, b) -> Format.fprintf fmt "%d%a" b pp_atom a))
      (Map.to_alist term)
      pp_rel
      rel
      c
  | Reg (regex, atoms) ->
    Format.fprintf
      fmt
      "(%a %a)"
      Regex.pp
      regex
      (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt " + ") pp_atom)
      atoms
  | Lnot ir -> Format.fprintf fmt "~%a" pp ir
  | Land irs ->
    Format.fprintf
      fmt
      "(%a)"
      (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt " & ") pp)
      irs
  | Lor irs ->
    Format.fprintf
      fmt
      "(%a)"
      (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt " | ") pp)
      irs
  | Exists (atoms, ir) ->
    Format.fprintf
      fmt
      "(exists (%a) %a)"
      (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt ", ") pp_atom)
      atoms
      pp
      ir
;;

let rec map2 f fleaf ir =
  match ir with
  | True -> fleaf ir
  | Rel (_, _, _) -> fleaf ir
  | Reg (_, _) -> fleaf ir
  | Lnot ir' -> f (lnot (map2 f fleaf ir'))
  | Land irs -> f (land_ (List.map (map2 f fleaf) irs))
  | Lor irs -> f (lor_ (List.map (map2 f fleaf) irs))
  | Exists (atoms, ir') -> f (exists atoms (map2 f fleaf ir'))
;;

let map f ir = map2 f f ir

let rec fold f acc ir =
  match ir with
  | True -> f acc ir
  | Rel _ -> f acc ir
  | Reg (_, _) -> f acc ir
  | Lnot ir' -> f (fold f acc ir') ir
  | Land irs -> f (List.fold_left (fold f) acc irs) ir
  | Lor irs -> f (List.fold_left (fold f) acc irs) ir
  | Exists (_, ir') -> f (fold f acc ir') ir
;;

let for_all f ir = fold (fun acc ir -> f ir |> ( && ) acc) true ir
let for_some f ir = fold (fun acc ir -> f ir |> ( || ) acc) false ir
