a.03.koat_76
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_76.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ it175 + (* -1 * it159 * (0 ** it134)) + (* -1 * (0 ** it134))) = 0")
  TIMEOUT
