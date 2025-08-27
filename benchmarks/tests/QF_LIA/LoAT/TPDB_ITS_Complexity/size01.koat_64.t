size01.koat_64
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size01.koat_64.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ it377 + (* -1 * i4 * (-1 ** it48))) = 0")
  TIMEOUT
