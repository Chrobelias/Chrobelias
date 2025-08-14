a.03.koat_38
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_38.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ -2 + (* -1 * (2 ** it57) * it25)) = 0")
  TIMEOUT
