a.03.koat_1041
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_1041.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 0 <= (+ -1 + it1234 + (* -1 * it1236 * (2 ** (+ -1 + it57))))")
  TIMEOUT
