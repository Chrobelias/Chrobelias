a.03.koat_692
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_692.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 0 <= (+ 1 + (* -1 * it1095 * (2 ** (+ -1 + it134))) + it1093 + (* -1 * (2 ** it134)))")
  TIMEOUT
