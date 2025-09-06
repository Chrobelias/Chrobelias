(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly

val option_map_to_map_option : ('a, 'b option) Map.t -> ('a, 'b) Map.t option
val pow : base:int -> int -> int
val powz : base:Z.t -> Z.t -> Z.t
val log : ('a, Format.formatter, unit) format -> 'a
