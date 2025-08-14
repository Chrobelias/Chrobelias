p-46.t2_fixed.smt2_10
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_LIA/LoAT/TPDB_ITS_Termination/p-46.t2_fixed.smt2_10.smt2 || echo TIMEOUT
  Fatal error: exception Failure("only base 2 is supported in exponents (got 3)")
  TIMEOUT
