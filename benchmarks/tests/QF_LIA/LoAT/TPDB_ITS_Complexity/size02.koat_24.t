size02.koat_24
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size02.koat_24.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* 12 * it3 * (it13 ** 2)) + (* -8 * (it13 ** 3)) + (* 6 * (it13 ** 2)) + (* -6 * it3 * it13) + (* -3 * it6) + (* -6 * (it3 ** 2) * it13) + (* 3 * it19) + (* -1 * it13)) = 0")
  TIMEOUT
