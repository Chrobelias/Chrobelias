size10.koat_35
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size10.koat_35.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* -6 * (it3 ** 0) * it120) + (* 3 * it189) + (* 6 * (it120 ** 0)) + (* -8 * (it120 ** 3)) + (* 12 * it3 * (it120 ** 0)) + (* -6 * it3 * it120) + (* -3 * it6) + (* -1 * it120)) = 0")
  TIMEOUT
