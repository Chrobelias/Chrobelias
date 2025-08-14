a.03.koat_410
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_410.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented 0 <= (+ 2 + (* -1 * (2 ** it134)) + it381 + (* -1 * it383 * (2 ** (+ -1 + it134))))")
  TIMEOUT
