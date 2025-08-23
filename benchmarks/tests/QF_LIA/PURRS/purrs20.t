purrs20
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs20.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (* (a ** n) * x0) = (* a * (a ** (+ -1 + n)) * x0)")
  TIMEOUT
