type t = (string, [ `Int of Z.t | `Str of string | `Bool of bool ]) Base.Map.Poly.t
type tys = (string, [ `Int | `Str | `Bool ]) Base.Map.Poly.t

val pp : Format.formatter -> t -> unit
val to_string : t -> string
