purrs02
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs02.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (* (+ x + n) * (2 ** n)) = (+ (* 2 * (+ -1 + x + n) * (2 ** (+ -1 + n))) + (2 ** n))")
  TIMEOUT
