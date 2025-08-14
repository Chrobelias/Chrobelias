size01.koat_76
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_76.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* 12 * (it48 ** 2) * (it436 ** 2) * it3) + (* -1 * it48 * it436) + (* 12 * (it436 ** 2) * it3 * (it13 ** 2)) + (* 24 * it48 * (it436 ** 2) * it3 * it13) + (* -6 * it48 * it436 * it3) + (* 6 * (it436 ** 2) * (it13 ** 2)) + (* -24 * it48 * (it436 ** 3) * (it13 ** 2)) + (* -6 * it436 * (it3 ** 2) * it13) + (* -8 * (it436 ** 3) * (it13 ** 3)) + (* -6 * it48 * it436 * (it3 ** 2)) + (* 12 * it48 * (it436 ** 2) * it13) + (* 3 * it444) + (* -3 * it6) + (* 6 * (it48 ** 2) * (it436 ** 2)) + (* -6 * it436 * it3 * it13) + (* -1 * it436 * it13) + (* -8 * (it48 ** 3) * (it436 ** 3)) + (* -24 * (it48 ** 2) * (it436 ** 3) * it13)) = 0")
  TIMEOUT
