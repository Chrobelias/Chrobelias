(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

module Map = Base.Map.Poly

val list : unit -> unit
val pred : string -> string list -> Ast.formula -> (unit, string) result
val predr : string -> Regex.t -> (unit, string) result
val dump : Ast.formula -> (string, string) result
val proof : Ast.formula -> (bool, string) result
val get_model : Ast.formula -> ((string, int) Map.t option, string) result
