size10.koat_18
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size10.koat_18.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* -6 * (it3 ** 2) * it120) + (* 6 * (it120 ** 2)) + (* -8 * (it120 ** 3)) + (* 12 * it3 * (it120 ** 2)) + (* -6 * it3 * it120) + (* -3 * it6) + (* 3 * it126) + (* -1 * it120)) = 0")
  TIMEOUT
