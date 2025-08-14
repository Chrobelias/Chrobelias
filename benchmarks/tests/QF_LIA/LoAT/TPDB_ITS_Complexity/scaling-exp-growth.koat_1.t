scaling-exp-growth.koat_1
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/scaling-exp-growth.koat_1.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ (* -1 * (2 ** it4) * it3) + it12) = 0")
  TIMEOUT
