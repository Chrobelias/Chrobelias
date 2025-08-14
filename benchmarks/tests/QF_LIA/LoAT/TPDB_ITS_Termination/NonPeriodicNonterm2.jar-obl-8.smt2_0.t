NonPeriodicNonterm2.jar-obl-8.smt2_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/NonPeriodicNonterm2.jar-obl-8.smt2_0.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 0 <= (+ it22 + (* -1 * (2 ** (+ -1 + it27))) + (* -1 * (2 ** (+ -1 + it27)) * it21) + it27)")
  TIMEOUT
