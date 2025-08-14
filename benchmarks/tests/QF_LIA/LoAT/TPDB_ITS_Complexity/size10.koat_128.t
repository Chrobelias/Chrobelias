size10.koat_128
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size10.koat_128.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* 12 * it385 * (it120 ** 2)) + (* -3 * it388) + (* 6 * (it120 ** 2)) + (* -6 * it385 * it120) + (* -8 * (it120 ** 3)) + (* 3 * it395) + (* -6 * (it385 ** 2) * it120) + (* -1 * it120)) = 0")
  TIMEOUT
