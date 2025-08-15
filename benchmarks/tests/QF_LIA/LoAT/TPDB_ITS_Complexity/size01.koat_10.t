size01.koat_10
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_10.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* 12 * (it48 ** 0) * (it73 ** 0) * it3) + (* 6 * (it48 ** 0) * (it73 ** 0)) + (* 12 * (it73 ** 0) * it3 * (it13 ** 0)) + (* -6 * it48 * it73 * it3) + (* 24 * it48 * (it73 ** 0) * it3 * it13) + (* 6 * (it73 ** 0) * (it13 ** 0)) + (* -8 * (it73 ** 3) * (it13 ** 3)) + (* -24 * it48 * (it73 ** 3) * (it13 ** 0)) + (* -6 * it73 * (it3 ** 0) * it13) + (* -6 * it48 * it73 * (it3 ** 0)) + (* 12 * it48 * (it73 ** 0) * it13) + (* -8 * (it48 ** 3) * (it73 ** 3)) + (* -3 * it6) + (* -1 * it48 * it73) + (* 3 * it81) + (* -1 * it73 * it13) + (* -6 * it73 * it3 * it13) + (* -24 * (it48 ** 0) * (it73 ** 3) * it13)) = 0")
  TIMEOUT
