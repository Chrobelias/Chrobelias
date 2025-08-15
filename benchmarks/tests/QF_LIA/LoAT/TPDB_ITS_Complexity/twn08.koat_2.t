twn08.koat_2
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn08.koat_2.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 1 <= (+ (* 4 * ((2 ** (+ -1 + it256)) ** 2) * (it278 ** 2)) + (* -4 * (5 ** (+ -1 + it256)) * it277) + (* -1 * (5 ** (+ -1 + it256)) * (it279 ** 2)) + (it279 ** 2))")
  TIMEOUT
