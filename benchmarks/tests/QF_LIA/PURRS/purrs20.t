purrs20
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs20.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (* x0 * (a ** n)) = (* a * x0 * (a ** (+ -1 + n)))")
  TIMEOUT
