type t = (string, [ `Eia of Ast.Eia.term | `Str of Ast.Str.term ]) Base.Map.Poly.t

exception Occurs

val empty : t
val is_empty : t -> bool
val merge : t -> t -> t

val fold
  :  t
  -> init:'a
  -> f:(key:string -> data:[ `Eia of Ast.Eia.term | `Str of Ast.Str.term ] -> 'a -> 'a)
  -> 'a

val length : t -> int
val lookup : string -> t -> [ `Eia of Ast.Eia.term | `Str of Ast.Str.term ] option
val lookup_exn : string -> t -> [ `Eia of Ast.Eia.term | `Str of Ast.Str.term ]
val is_absent_key : string -> t -> bool
val extend_exn : t -> string -> [ `Eia of Ast.Eia.term | `Str of Ast.Str.term ] -> t
val pp : Format.formatter -> t -> unit
val to_eqs : t -> Ast.t list
val enrich : t -> (Ast.atom, [ `Int of Z.t | `Str of string ]) Base.Map.Poly.t -> t
val occurs_var : t -> string -> [ `Eia of Ast.Eia.term | `Str of Ast.Str.term ] -> bool

val walk
  :  t
  -> [ `Eia of Ast.Eia.term | `Str of Ast.Str.term ]
  -> [ `Eia of Ast.Eia.term | `Str of Ast.Str.term ]
