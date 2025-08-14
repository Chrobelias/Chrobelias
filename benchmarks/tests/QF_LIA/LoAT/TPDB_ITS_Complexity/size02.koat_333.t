size02.koat_333
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_333.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* -6 * (it1184 ** 0) * it13) + (* -8 * (it13 ** 3)) + (* 6 * (it13 ** 0)) + (* 3 * it1473) + (* 12 * it1184 * (it13 ** 0)) + (* -3 * it1187) + (* -1 * it13) + (* -6 * it1184 * it13)) = 0")
  TIMEOUT
