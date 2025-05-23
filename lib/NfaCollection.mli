(* SPDX-License-Identifier: MIT *)
(* Copyright 2024-2025, Chrobelias. *)

type varpos = int

val add : lhs:varpos -> rhs:varpos -> res:varpos -> Nfa.t
val eq : varpos -> varpos -> Nfa.t
val neq : varpos -> varpos -> Nfa.t
val eq_const : varpos -> int -> Nfa.t
val n : unit -> Nfa.t
val z : unit -> Nfa.t
val leq : varpos -> varpos -> Nfa.t
val geq : varpos -> varpos -> Nfa.t
val lt : varpos -> varpos -> Nfa.t
val gt : varpos -> varpos -> Nfa.t
val torename : varpos -> int -> int -> Nfa.t
val torename2 : int -> int -> Nfa.t
val power_of_two : int -> Nfa.t
val mul : res:varpos -> lhs:int -> rhs:varpos -> Nfa.t
val bvor : lhs:varpos -> rhs:varpos -> res:varpos -> Nfa.t
val bvand : lhs:varpos -> rhs:varpos -> res:varpos -> Nfa.t
val bvxor : lhs:varpos -> rhs:varpos -> res:varpos -> Nfa.t
