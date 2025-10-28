type t

exception Occurs

val empty : t

(* val is_empty : t -> bool *)
val merge : t -> t -> t
val fold : t -> init:'a -> f:(key:string -> data:Ast.Eia.term -> 'a -> 'a) -> 'a
val length : t -> int
val lookup : string -> t -> Ast.Eia.term option
val lookup_exn : string -> t -> Ast.Eia.term
val is_absent_key : string -> t -> bool
val extend_exn : t -> string -> Ast.Eia.term -> t
val extend_cstrt_exn : t -> key:string -> Ast.Eia.term -> t
val pp : ?title:string -> Format.formatter -> t -> unit
val to_eqs : t -> Ast.t list
val enrich : t -> (Ast.atom, [ `Int of Z.t | `Str of string ]) Base.Map.Poly.t -> t
val occurs_var : t -> string -> Ast.Eia.term -> bool
val walk : t -> Ast.Eia.term -> Ast.Eia.term

val filter_mapi
  :  f:(key:string -> data:Ast.Eia.term -> 'a option)
  -> t
  -> (string, 'a) Base.Map.Poly.t
