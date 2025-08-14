a.03.koat_465
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Complexity/a.03.koat_465.smt2 || echo TIMEOUT
  Fatal error: exception Failure("only base 2 is supported in exponents (got 0)")
  TIMEOUT
