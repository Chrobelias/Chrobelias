purrs11
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs11.smt2 || echo TIMEOUT
  Fatal error: exception Failure("unimplemented (* (+ (* 2 * (+ 1 + (* -1 * n)) * x0) + (* x1 * n) + (* n * (+ -1 + n))) * (2 ** (+ -1 + n))) = (+ (* 4 * (+ (* 2 * (+ 1 + (* -1 * (+ -1 + n))) * x0) + (* x1 * (+ -1 + n)) + (* (+ -1 + n) * (+ -2 + n))) * (2 ** (+ -2 + n))) + (* -4 * (+ (* 2 * (+ 1 + (* -1 * (+ -2 + n))) * x0) + (* x1 * (+ -2 + n)) + (* (+ -2 + n) * (+ -3 + n))) * (2 ** (+ -3 + n))) + (2 ** n))")
  TIMEOUT
