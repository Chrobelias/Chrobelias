size02.koat_64
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_64.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* -1 * it127) + (* -6 * it127 * (it255 ** 0)) + (* -3 * it258) + (* 3 * it291) + (* -6 * it127 * it255) + (* -8 * (it127 ** 3)) + (* 12 * (it127 ** 0) * it255) + (* 6 * (it127 ** 0))) = 0")
  TIMEOUT
