size04.koat_64
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size04.koat_64.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* -3 * it258) + (* -6 * it255 * it127) + (* 12 * it255 * (it127 ** 0)) + (* 6 * (it127 ** 0)) + (* -8 * (it127 ** 3)) + (* -1 * it127) + (* 3 * it291) + (* -6 * (it255 ** 0) * it127)) = 0")
  TIMEOUT
