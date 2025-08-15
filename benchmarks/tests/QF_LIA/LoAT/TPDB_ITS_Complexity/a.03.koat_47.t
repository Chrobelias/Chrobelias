a.03.koat_47
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_47.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 0 <= (+ 2 + (* -1 * it159 * (2 ** (+ -1 + it134))) + it157 + (* -1 * (2 ** it134)))")
  TIMEOUT
