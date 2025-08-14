size01.koat_20
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_20.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* 12 * (it84 ** 0) * it78) + (* -8 * (it84 ** 3)) + (* -1 * it84) + (* -3 * it81) + (* 6 * (it84 ** 0)) + (* -6 * it84 * (it78 ** 0)) + (* -6 * it84 * it78) + (* 3 * it137)) = 0")
  TIMEOUT
