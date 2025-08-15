ex006.koat_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/ex006.koat_0.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 0 <= (+ (* -1 * it4 * (3 ** (+ -1 + it9))) + (* (2 ** (+ -1 + it9)) * it3))")
  TIMEOUT
