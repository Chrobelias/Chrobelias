NonPeriodicNonterm2.jar-obl-8.smt2_2
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/NonPeriodicNonterm2.jar-obl-8.smt2_2.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 0 <= (+ it13 + (* -1 * (2 ** (+ -1 + it27))) + (* -1 * (2 ** (+ -1 + it27)) * it12) + it27)")
  TIMEOUT
