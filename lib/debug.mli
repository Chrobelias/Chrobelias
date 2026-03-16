(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

val flag : unit -> bool
val enforce_debug : bool ref
val is_traced : string -> bool
val trace : string -> ('a, Format.formatter, unit, unit) format4 -> 'a

val dump_nfa
  :  ?msg:(string -> unit, Format.formatter, unit) format
  -> ?pp_vars:(Format.formatter -> 'b -> unit)
  -> ?vars:'b
  -> (Format.formatter -> 'a -> unit)
  -> 'a
  -> unit

(* TODO(Kakadu): Rework logging
  At the moment we evaluate function's arguments anyway and after that decide whether
  will log visibly, or not. State-of-the-art libraries avoid this. See for details:

    https://erratique.ch/software/logs/doc/Logs/index.html
    https://github.com/janestreet/ppx_log/tree/master/doc
*)
