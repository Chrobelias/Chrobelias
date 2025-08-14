size01.koat_114
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_114.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* 6 * (it73 ** 2) * (it447 ** 2)) + (* -8 * (it73 ** 3) * (it501 ** 3)) + (* 12 * (it73 ** 2) * it447 * it501) + (* 3 * it600) + (* -6 * it73 * it497 * it501) + (* -6 * it73 * it447 * (it497 ** 2)) + (* -24 * (it73 ** 3) * (it447 ** 2) * it501) + (* -6 * it73 * it447 * it497) + (* 6 * (it73 ** 2) * (it501 ** 2)) + (* -8 * (it73 ** 3) * (it447 ** 3)) + (* 12 * (it73 ** 2) * (it447 ** 2) * it497) + (* -3 * it500) + (* -1 * it73 * it447) + (* 12 * (it73 ** 2) * it497 * (it501 ** 2)) + (* -6 * it73 * (it497 ** 2) * it501) + (* -24 * (it73 ** 3) * it447 * (it501 ** 2)) + (* 24 * (it73 ** 2) * it447 * it497 * it501) + (* -1 * it73 * it501)) = 0")
  TIMEOUT
