size03.koat_23
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size03.koat_23.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* 12 * it3 * (it13 ** 0)) + (* -8 * (it13 ** 3)) + (* 6 * (it13 ** 0)) + (* -6 * it3 * it13) + (* -3 * it6) + (* -6 * (it3 ** 0) * it13) + (* 3 * it19) + (* -1 * it13)) = 0")
  TIMEOUT
