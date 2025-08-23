purrs18
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs18.smt2 || echo TIMEOUT
  Fatal error: exception Failure("only base 2 is supported in exponents (got 3)")
  TIMEOUT
