module M(Enc : Nfa.Encoding) : sig
  type t

  exception Occurs

  val empty : t

  (* val is_empty : t -> bool *)
  val merge_exn : t -> t -> t
  val equal : t -> t -> bool

  val merge
    :  sf:
         (key:string
          -> data1:string Ast.M(Enc).Eia.term
          -> data2:string Ast.M(Enc).Eia.term
          -> string Ast.M(Enc).Eia.term)
    -> zf:
         (key:string
          -> data1:Z.t Ast.M(Enc).Eia.term
          -> data2:Z.t Ast.M(Enc).Eia.term
          -> Z.t Ast.M(Enc).Eia.term)
    -> t
    -> t
    -> t

  val fold : t -> init:'a -> f:(key:string -> data:Ast.M(Enc).typed_term -> 'a -> 'a) -> 'a

  val filter_mapi
    :  fstr:(string -> string Ast.M(Enc).Eia.term -> string Ast.M(Enc).Eia.term option)
    -> fint:(string -> Z.t Ast.M(Enc).Eia.term -> Z.t Ast.M(Enc).Eia.term option)
    -> t
    -> t

  val length : t -> int
  val lookup_int : string -> t -> Z.t Ast.M(Enc).Eia.term option
  val lookup_int_exn : string -> t -> Z.t Ast.M(Enc).Eia.term
  val lookup_string : string -> t -> string Ast.M(Enc).Eia.term option
  val lookup_string_exn : string -> t -> string Ast.M(Enc).Eia.term

  (* TODO: remove this  *)
  val is_absent_key : string -> t -> bool
  val extend_exn : t -> 'a Ast.atom -> 'a Ast.M(Enc).Eia.term -> t
  val set_int_exn : t -> string -> Z.t Ast.M(Enc).Eia.term -> t
  val extend_int_exn : t -> string -> Z.t Ast.M(Enc).Eia.term -> t
  val extend_string_exn : t -> string -> string Ast.M(Enc).Eia.term -> t
  val extend_cstrt_exn : t -> key:'a Ast.atom -> 'a Ast.M(Enc).Eia.term -> t
  val pp : ?title:string -> Format.formatter -> t -> unit
  val to_eqs : t -> Ast.M(Enc).t list
  val enrich : t -> (Ast.any_atom, [ `Int of Z.t | `Str of string ]) Base.Map.Poly.t -> t
  val occurs_var : t -> string -> 'a Ast.M(Enc).Eia.term -> bool
  val walk : t -> 'a Ast.M(Enc).Eia.term -> 'a Ast.M(Enc).Eia.term
end

(** Was needed for mergin models *)
(* val filter_mapi
  :  f:(key:string -> data:Ast.M(Enc).Eia.term -> 'a option)
  -> t
  -> (string, 'a) Base.Map.Poly.t *)
