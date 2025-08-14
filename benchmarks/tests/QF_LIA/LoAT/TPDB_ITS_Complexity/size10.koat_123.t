size10.koat_123
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size10.koat_123.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* -1 * it285 * it284) + (* -1 * it391) + (* -1 * it264 * it284) + it416 + (* -4 * it284)) = 0")
  TIMEOUT
