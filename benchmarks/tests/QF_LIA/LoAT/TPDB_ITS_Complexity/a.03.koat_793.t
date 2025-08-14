a.03.koat_793
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_793.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 0 <= (+ -1 + it1307 + (* -1 * (2 ** (+ -1 + it57)) * it1309))")
  TIMEOUT
