size03.koat_79
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size03.koat_79.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* -8 * (it127 ** 3) * (it152 ** 3)) + (* -1 * it152 * it13) + (* -24 * (it127 ** 2) * (it152 ** 3) * it13) + (* 6 * (it127 ** 2) * (it152 ** 2)) + (* -6 * it152 * it3 * it13) + (* 24 * it127 * (it152 ** 2) * it3 * it13) + (* -3 * it6) + (* -6 * it152 * (it3 ** 2) * it13) + (* -6 * it127 * it152 * it3) + (* 12 * (it127 ** 2) * (it152 ** 2) * it3) + (* -8 * (it152 ** 3) * (it13 ** 3)) + (* 12 * it127 * (it152 ** 2) * it13) + (* -1 * it127 * it152) + (* 12 * (it152 ** 2) * it3 * (it13 ** 2)) + (* 6 * (it152 ** 2) * (it13 ** 2)) + (* 3 * it160) + (* -24 * it127 * (it152 ** 3) * (it13 ** 2)) + (* -6 * it127 * it152 * (it3 ** 2))) = 0")
  TIMEOUT
