type t = (string, Ast.Eia.term) Base.Map.Poly.t

exception Occurs

val empty : t
val merge : t -> t -> t
val fold : t -> init:'a -> f:(key:string -> data:Ast.Eia.term -> 'a -> 'a) -> 'a
val length : t -> int
val enrich : t -> (Ast.atom, [ `Int of Z.t | `Str of string ]) Base.Map.Poly.t -> t
val pp : Format.formatter -> t -> unit
val lookup : string -> t -> Ast.Eia.term option
val is_absent_key : string -> t -> bool
val extend_exn : t -> string -> Ast.Eia.term -> t
val to_eqs : t -> Ast.t list
