val is_traced : string -> bool
val trace : string -> ('a, Format.formatter, unit, unit) format4 -> 'a

val dump_nfa
  :  ?msg:(string -> unit, Format.formatter, unit) format
  -> ?pp_vars:(Format.formatter -> 'b -> unit)
  -> ?vars:'b
  -> (Format.formatter -> 'a -> unit)
  -> 'a
  -> unit
