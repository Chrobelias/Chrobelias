module Map = Base.Map.Poly

(* TODO: the perfect implementation should differentiate between atoms in *)
(* different theories. But it requires a lot more complex parsing due to *)
(* the state that should be stored. So let's stick with simpler stuff now. *)
type atom =
  [ `Var of string
  | `Internal of string
  | `Pow2 of string
  ]
[@@deriving variants]

type poly_atom =
  [ `Var of string
  | `Internal of string
  | `Pow2 of string
  | `Poly of (atom, int) Map.t
  ]

let internal () = internal (Random.int 1073741822 |> string_of_int)

let pp_atom fmt = function
  | `Var var -> Format.fprintf fmt "%s" var
  | `Internal var -> Format.fprintf fmt "[%s]" var
  | `Pow2 var -> Format.fprintf fmt "pow2(%s)" var
;;

let pp_poly_atom fmt = function
  | #atom as atom -> pp_atom fmt atom
  | `Poly poly ->
    Format.fprintf
      fmt
      "(%a)"
      (Format.pp_print_list
         ~pp_sep:(fun fmt () -> Format.fprintf fmt " * ")
         (fun fmt (var, exp) -> Format.fprintf fmt "%a^%d" pp_atom var exp))
      (poly |> Map.to_alist)
;;

(** Exponential integer arithmetic, i.e. LIA with exponents.*)
module Eia = struct
  type 'atom t = Sum of ('atom, int) Map.t [@@deriving variants]

  let pp fmt = function
    | Sum term ->
      Format.fprintf
        fmt
        "%a"
        (Format.pp_print_list
           ~pp_sep:(fun fmt () -> Format.fprintf fmt " + ")
           (fun fmt (a, b) -> Format.fprintf fmt "%d%a" b pp_poly_atom a))
        (Map.to_alist term)
  ;;

  let neg (Sum sum) = Sum (Map.map ~f:( ~- ) sum)

  type 'atom ir =
    | Eq of 'atom t * int
    | Leq of 'atom t * int
  [@@deriving variants (* , show *)]

  let map_ir f = function
    | Eq (term, c) ->
      (match f term c with
       | term, c -> Eq (term, c))
    | Leq (term, c) ->
      (match f term c with
       | term, c -> Leq (term, c))
  ;;

  let pp_ir fmt = function
    | Eq (term, c) -> Format.fprintf fmt "%a = %d" pp term c
    | Leq (term, c) -> Format.fprintf fmt "%a <= %d" pp term c
  ;;

  let equal formula formula' =
    match formula, formula' with
    | Eq (Sum term, c), Eq (Sum term', c') | Leq (Sum term, c), Leq (Sum term', c') ->
      Map.equal ( = ) term term' && c = c'
    | _, _ -> false
  ;;

  let lt t c = leq t (pred c)
  let geq t c = leq (neg t) (-c)
  let gt t c = leq (neg t) (pred ~-c)
end

(** Bitvectors. *)
module Bv = struct
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
end

type 'atom t =
  | True
  (* Theories. *)
  | Eia of 'atom Eia.ir
  | Bv of Bv.ir
  (* Logical operations. *)
  | Lnot of 'atom t
  | Land of 'atom t list
  | Lor of 'atom t list
  | Exists of atom list * 'atom t
  | Pred of string * 'atom Eia.t list
[@@deriving variants]

let rec pp fmt = function
  | True -> Format.fprintf fmt "true"
  | Eia ir -> Format.fprintf fmt "%a" Eia.pp_ir ir
  | Bv ir -> Format.fprintf fmt "%a" Bv.pp_ir ir
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
  | Pred (name, args) ->
    Format.fprintf
      fmt
      "%s(%a)"
      name
      (Format.pp_print_list ~pp_sep:(fun fmt () -> Format.fprintf fmt " ") Eia.pp)
      args
;;

(* Structural equivalence of the IR formulas. *)
let rec equal ir ir' =
  match ir, ir' with
  | True, True -> true
  | Eia eia_ir, Eia eia_ir' -> Eia.equal eia_ir eia_ir'
  | Bv bv_ir, Bv bv_ir' -> Bv.equal bv_ir bv_ir'
  | Lnot ir, Lnot ir' -> equal ir ir'
  | Land irs, Land irs' | Lor irs, Lor irs' -> List.for_all2 equal irs irs'
  | Exists (atoms, ir), Exists (atoms', ir') ->
    List.equal ( = ) atoms atoms' && equal ir ir'
  | _, _ -> false
;;

let rec map2 f fleaf ir =
  match ir with
  | True | Eia _ | Bv _ | Pred _ -> fleaf ir
  | Lnot ir' -> f (lnot (map2 f fleaf ir'))
  | Land irs -> f (land_ (List.map (map2 f fleaf) irs))
  | Lor irs -> f (lor_ (List.map (map2 f fleaf) irs))
  | Exists (atoms, ir') -> f (exists atoms (map2 f fleaf ir'))
;;

let map f ir = map2 f f ir

let rec fold f acc ir =
  match ir with
  | True | Eia _ | Bv _ | Pred (_, _) -> f acc ir
  | Lnot ir' -> f (fold f acc ir') ir
  | Land irs -> f (List.fold_left (fold f) acc irs) ir
  | Lor irs -> f (List.fold_left (fold f) acc irs) ir
  | Exists (_, ir') -> f (fold f acc ir') ir
;;

let for_all f ir = fold (fun acc ir -> f ir |> ( && ) acc) true ir
let for_some f ir = fold (fun acc ir -> f ir |> ( || ) acc) false ir
