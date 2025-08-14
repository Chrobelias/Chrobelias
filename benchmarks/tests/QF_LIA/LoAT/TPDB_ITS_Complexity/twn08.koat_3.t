twn08.koat_3
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/twn08.koat_3.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 1 <= (+ (* 4 * ((2 ** (+ -1 + it256)) ** 2) * (it286 ** 2)) + (* -1 * (5 ** (+ -1 + it256)) * (it287 ** 2)) + (it287 ** 2) + (* -4 * (5 ** (+ -1 + it256)) * it285))")
  TIMEOUT
