loop16.koat_2
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/loop16.koat_2.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ 10 + it11 + (* -1 * it3 * (2 ** it7)) + (* -10 * (2 ** it7))) = 0")
  TIMEOUT
