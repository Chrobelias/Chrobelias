module Map = Base.Map.Poly
module Set = Base.Set.Poly

exception Timeout

val option_map_to_map_option : ('a, 'b option) Map.t -> ('a, 'b) Map.t option
val pow : base:int -> int -> int
val powz : base:Z.t -> Z.t -> Z.t
val div_rem : Z.t -> Z.t -> Z.t * Z.t
val to_bits : Z.t -> bool list
val powerset : 'a list -> 'a list list
val cartesian : 'a list list -> 'a list list
val cartesian2 : 'a list list -> 'a list list
val strings_of_len : int -> string list -> string list
val with_extra_char : char Set.t -> char list
val find_map_n : int -> ('a -> 'b option) -> 'a list -> 'b list
val div_floor : Z.t -> Z.t -> Z.t
val div_ceil : Z.t -> Z.t -> Z.t
val unique : 'a list -> 'a list
