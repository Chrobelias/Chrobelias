loop16.koat_0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/loop16.koat_0.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 0 <= (+ 109 + (* -1 * it3 * (2 ** (+ -1 + it7))) + (* -10 * (2 ** (+ -1 + it7))))")
  TIMEOUT
