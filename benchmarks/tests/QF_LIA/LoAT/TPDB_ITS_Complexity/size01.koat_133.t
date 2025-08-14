size01.koat_133
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_133.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* -1 * it48) + (* 12 * (it48 ** 0) * it3) + (* -3 * it6) + (* 6 * (it48 ** 0)) + (* -6 * it48 * (it3 ** 0)) + (* -8 * (it48 ** 3)) + (* 3 * it843) + (* -6 * it48 * it3)) = 0")
  TIMEOUT
