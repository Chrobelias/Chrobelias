[Overapprox.in_re] turns "s in re" into a disjunction over the accepted length
progressions and trusts the result as an over-approximation, so a ChrobakNF
truncated to 8 states drops progressions and refutes this satisfiable formula.
The bounds are armed for the elimination stage alone (Config.dyn_stage). The
cap is pinned here rather than left at the default, which is free to move.

  $ CHRO_DYN_SCAN=64 Chro -q -no-model dyn-bounds-lengths.smt2
  sat (under int)
