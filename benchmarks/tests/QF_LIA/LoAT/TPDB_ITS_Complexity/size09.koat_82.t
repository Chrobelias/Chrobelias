size09.koat_82
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size09.koat_82.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ -6 + (* -6 * ((+ -1 + (* -1 * it7)) ** 0) * it15) + (* -6 * it588 * ((+ -1 + (* -1 * it7)) ** 0)) + (* 6 * it190 * it81 * (+ -1 + it589) * it425) + (* -1 * it588) + (* 6 * it190 * it81 * (+ -1 + it425)) + (* -3 * it7) + (* 6 * it588 * (+ -1 + (* -1 * it7))) + (* 6 * (+ -1 + it373) * it424) + (* -12 * (+ -1 + (* -1 * it7)) * (it15 ** 0)) + (* -12 * (it588 ** 0) * (+ -1 + (* -1 * it7))) + (* 6 * it424) + (* -1 * it15) + (* 6 * it373 * it424 * (+ -1 + it425)) + (* 6 * (it15 ** 0)) + (* 6 * it190 * it81) + (* -8 * (it588 ** 3)) + (* 6 * it373 * it424 * (+ -1 + it589) * it425) + (* 6 * (+ -1 + (* -1 * it7)) * it15) + (* 6 * (it588 ** 0)) + (* 3 * it603) + (* -8 * (it15 ** 3))) = 0")
  TIMEOUT
