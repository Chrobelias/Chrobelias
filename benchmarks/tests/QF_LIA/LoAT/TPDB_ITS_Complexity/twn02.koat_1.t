twn02.koat_1
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn02.koat_1.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 1 <= (+ (* -4 * (5 ** (+ -1 + it11)) * it3) + (* 4 * ((2 ** (+ -1 + it11)) ** 2) * (it4 ** 2)) + (* -1 * (5 ** (+ -1 + it11)) * (it5 ** 2)) + (it5 ** 2))")
  TIMEOUT
