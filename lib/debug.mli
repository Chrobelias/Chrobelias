(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

val flag : unit -> bool
val fmt : Format.formatter
val printf : ('a, Format.formatter, unit) format -> 'a
val printfln : ('a, Format.formatter, unit) format -> 'a

val dump_nfa
  :  ?msg:(string -> unit, Format.formatter, unit, unit, unit, unit) format6
  -> ?vars:(Ir.atom * int) list
  -> (Format.formatter -> 'a -> unit)
  -> 'a
  -> unit

(* TODO(Kakadu): Rework logging
  At the moment we evaluate function's arguments anyway and after that decide whether
  will log visibly, or not. State-of-the-art libraries avoid this. See for details:

    https://erratique.ch/software/logs/doc/Logs/index.html
    https://github.com/janestreet/ppx_log/tree/master/doc
*)
