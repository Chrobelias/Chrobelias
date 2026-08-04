(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2026, Chrobelias. *)

module Map = Base.Map.Poly
module Set = Base.Set.Poly

val option_map_to_map_option : ('a, 'b option) Map.t -> ('a, 'b) Map.t option
val pow : base:int -> int -> int
val powz : base:Z.t -> Z.t -> Z.t
val logBase : int -> base:Z.t -> int
val logBaseZ : Z.t -> base:Z.t -> int
val div_rem : Z.t -> Z.t -> Z.t * Z.t
val to_bits : Z.t -> bool list
val powerset : 'a list -> 'a list list

(** [cartesian [l1; ...; ln]] enumerates all the lists [[x1; ...; xn]] with
    [xi] taken from [li]; empty as soon as one of the [li] is empty. *)
val cartesian : 'a list list -> 'a list list

val powerset_seq : 'a list -> 'a list Seq.t
val strings_of_len : int -> string list -> string list
val with_extra_char : char Set.t -> char list
