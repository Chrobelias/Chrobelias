type t

exception Occurs
exception BadArg

val empty : t
val merge_exn : t -> t -> t
val equal : t -> t -> bool

val merge
  :  sf:
       (key:string
        -> data1:string Ast.RLia.term
        -> data2:string Ast.RLia.term
        -> string Ast.RLia.term)
  -> zf:
       (key:string
        -> data1:Z.t Ast.RLia.term
        -> data2:Z.t Ast.RLia.term
        -> Z.t Ast.RLia.term)
  -> t
  -> t
  -> t

val fold : t -> init:'a -> f:(key:string -> data:Ast.typed_term -> 'a -> 'a) -> 'a

val filter_mapi
  :  fstr:(string -> string Ast.RLia.term -> string Ast.RLia.term option)
  -> fint:(string -> Z.t Ast.RLia.term -> Z.t Ast.RLia.term option)
  -> t
  -> t

val length : t -> int
val definite_length : t -> int
val lookup_int : string -> t -> Z.t Ast.RLia.term option
val lookup_int_exn : string -> t -> Z.t Ast.RLia.term
val lookup_string : string -> t -> string Ast.RLia.term option
val lookup_string_exn : string -> t -> string Ast.RLia.term
val is_absent_key : string -> t -> bool
val extend_exn : t -> 'a Ast.atom -> 'a Ast.RLia.term -> t
val set_int_exn : t -> string -> Z.t Ast.RLia.term -> t
val set_string_exn : t -> string -> string Ast.RLia.term -> t
val extend_int_exn : t -> string -> Z.t Ast.RLia.term -> t
val extend_string_exn : t -> string -> string Ast.RLia.term -> t
val extend_cstrt_exn : t -> key:'a Ast.atom -> 'a Ast.RLia.term -> t
val pp : ?title:string -> Format.formatter -> t -> unit
val to_eqs : t -> Ast.t list
val enrich : t -> (Ast.any_atom, [ `Int of Z.t | `Str of string ]) Base.Map.Poly.t -> t
val enrich2 : t -> (Ir.atom, [ `Int of Z.t | `Str of string ]) Base.Map.Poly.t -> t
val occurs_var : t -> string -> 'a Ast.RLia.term -> bool
val walk : t -> 'a Ast.RLia.term -> 'a Ast.RLia.term
