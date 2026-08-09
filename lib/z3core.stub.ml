(* Selected when the z3 findlib package is absent -- e.g. the static release
   build strips z3's OCaml bindings (scripts/z3-static.opam seds libz3ml out
   of the install). The over-approximation just gives up: the DPLL loop stays
   complete, blocking whole candidates instead of small cores. *)
let check_length_core ~parts:_ ~facts:_ = `Unknown
