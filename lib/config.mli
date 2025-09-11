type t =
  { mutable stop_after : [ `Simpl | `Pre_simplify | `Solving ]
  ; mutable mode : [ `Msb | `Lsb ]
  ; mutable dump_simpl : bool
  ; mutable dump_pre_simpl : bool
  ; mutable dump_ir : bool
  ; mutable pre_simpl : bool (** Simplify the AST *)
  ; mutable error_check : bool
  ; mutable simpl_alpha : bool
  ; mutable simpl_mono : bool
  ; mutable over_approx : bool
  ; mutable under_approx : int
  ; mutable input_file : string
  ; mutable logic : [ `Eia | `Str ]
  ; mutable verbosity : int
  }

val parse_args : unit -> unit
val v : t
