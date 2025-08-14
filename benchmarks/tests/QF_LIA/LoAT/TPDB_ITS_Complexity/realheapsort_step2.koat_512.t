realheapsort_step2.koat_512
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/realheapsort_step2.koat_512.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 0 <= (+ 1 + (* -2 * (2 ** it1224)) + (* -1 * it1231) + (* -2 * (2 ** (+ -1 + it1224)) * it1232) + it1230)")
  TIMEOUT
