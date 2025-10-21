type t

exception Occurs

val empty : t

(* val is_empty : t -> bool *)
val merge_exn : t -> t -> t

val merge
  :  sf:
       (key:string
        -> data1:string Ast.Eia.term
        -> data2:string Ast.Eia.term
        -> string Ast.Eia.term)
  -> zf:
       (key:string
        -> data1:Z.t Ast.Eia.term
        -> data2:Z.t Ast.Eia.term
        -> Z.t Ast.Eia.term)
  -> t
  -> t
  -> t

val fold : t -> init:'a -> f:(key:string -> data:Ast.typed_term -> 'a -> 'a) -> 'a
val length : t -> int
val lookup_int : string -> t -> Z.t Ast.Eia.term option
val lookup_int_exn : string -> t -> Z.t Ast.Eia.term
val lookup_string : string -> t -> string Ast.Eia.term option
val lookup_string_exn : string -> t -> string Ast.Eia.term

(* TODO: remove this  *)
val is_absent_key : string -> t -> bool
val extend_exn : t -> 'a Ast.atom -> 'a Ast.Eia.term -> t
val set_int_exn : t -> string -> Z.t Ast.Eia.term -> t
val extend_int_exn : t -> string -> Z.t Ast.Eia.term -> t
val extend_string_exn : t -> string -> string Ast.Eia.term -> t
val extend_cstrt_exn : t -> key:'a Ast.atom -> 'a Ast.Eia.term -> t
val pp : ?title:string -> Format.formatter -> t -> unit
val to_eqs : t -> Ast.t list
val enrich : t -> (Ast.any_atom, [ `Int of Z.t | `Str of string ]) Base.Map.Poly.t -> t
val occurs_var : t -> string -> 'a Ast.Eia.term -> bool
val walk : t -> 'a Ast.Eia.term -> 'a Ast.Eia.term

(** Was needed for mergin models *)
(* val filter_mapi
  :  f:(key:string -> data:Ast.Eia.term -> 'a option)
  -> t
  -> (string, 'a) Base.Map.Poly.t *)
