Duplicate.jar-obl-8.smt2_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/Duplicate.jar-obl-8.smt2_0.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 1 <= (+ -1 + it10 + it17 + (* -1 * it11 * (2 ** (+ -1 + it17))))")
  TIMEOUT
