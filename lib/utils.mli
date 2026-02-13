(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly
module Set = Base.Set.Poly

val option_map_to_map_option : ('a, 'b option) Map.t -> ('a, 'b) Map.t option
val pow : base:int -> int -> int
val powz : base:Z.t -> Z.t -> Z.t
val log : ('a, Format.formatter, unit) format -> 'a
val powerset : 'a list -> 'a list list
val strings_of_len : int -> string list -> string list
val with_extra_char : char Set.t -> char Set.t
