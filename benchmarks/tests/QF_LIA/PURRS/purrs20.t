purrs20
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs20.smt2 || echo TIMEOUT
  Fatal error: exception Failure("only the same base 2 is supported in exponents (got a)")
  TIMEOUT
