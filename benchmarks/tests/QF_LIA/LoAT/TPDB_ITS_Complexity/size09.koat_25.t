size09.koat_25
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_25.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ -6 + (* 12 * (+ 1 + it7 + (* -2 * it81 * (+ -1 + it190)) + (* -2 * it81)) * (it160 ** 0)) + (* -3 * it7) + (* 6 * it81 * (+ -1 + it190)) + (* -6 * (+ 1 + it7 + (* -2 * it81 * (+ -1 + it190)) + (* -2 * it81)) * it160) + (* 3 * it198) + (* 6 * (it160 ** 0)) + (* -1 * it160) + (* -6 * ((+ 1 + it7 + (* -2 * it81 * (+ -1 + it190)) + (* -2 * it81)) ** 0) * it160) + (* -8 * (it160 ** 3)) + (* 6 * it81)) = 0")
  TIMEOUT
