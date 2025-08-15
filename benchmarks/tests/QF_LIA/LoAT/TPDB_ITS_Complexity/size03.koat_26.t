size03.koat_26
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size03.koat_26.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* -1 * it127) + (* 12 * (it127 ** 2) * it16) + (* 3 * it133) + (* -6 * it127 * it16) + (* 6 * (it127 ** 2)) + (* -3 * it19) + (* -8 * (it127 ** 3)) + (* -6 * it127 * (it16 ** 2))) = 0")
  TIMEOUT
