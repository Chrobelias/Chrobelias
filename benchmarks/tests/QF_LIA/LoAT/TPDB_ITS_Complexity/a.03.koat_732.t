a.03.koat_732
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_732.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ 2 + it1111 + (* -1 * (2 ** (+ 1 + it134))) + (* -1 * it1095 * (2 ** it134))) = 0")
  TIMEOUT
