a.03.koat_50
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_50.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* -1 * it159 * (2 ** it134)) + (* -1 * (2 ** (+ 1 + it134)))) = 0")
  TIMEOUT
