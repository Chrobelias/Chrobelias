NonPeriodicNonterm2.jar-obl-8.smt2_4
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/NonPeriodicNonterm2.jar-obl-8.smt2_4.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 1 <= (+ 1 + it19 + (* 2 * (2 ** (+ -1 + it42))) + (* 2 * (2 ** (+ -1 + it42)) * it12) + (* -2 * it19 * (2 ** (+ -1 + it42))))")
  TIMEOUT
