size03.koat_32
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/size03.koat_32.smt2 || echo TIMEOUT
  Fatal error: exception Failure("only base 2 is supported in exponents (got 0)")
  TIMEOUT
