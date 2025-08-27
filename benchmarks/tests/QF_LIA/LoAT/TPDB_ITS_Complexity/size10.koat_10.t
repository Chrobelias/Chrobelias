size10.koat_10
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size10.koat_10.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (+ it19 + (* -1 * i4 * (-1 ** it15))) = 0")
  TIMEOUT
