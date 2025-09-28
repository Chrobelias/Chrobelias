purrs18
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs18.smt2 -bound 0 || echo TIMEOUT
  unknown (converting to automaton expression: unimplemented (+ (* -15 * x0 * (2 ** (+ -1 + n))) + (* -12 * x0 * (3 ** (+ -2 + n))) + (* -6 * x1 * (2 ** (+ -2 + n))) + (* -4 * x1 * (3 ** n)) + (* -2 * x0 * (3 ** n)) + (* -1 * x1 * (2 ** n)) + (* 3 * x0 * (2 ** n)) + (* 5 * x1 * (2 ** (+ -1 + n))) + (* 6 * x1 * (3 ** (+ -2 + n))) + (* 10 * x0 * (3 ** (+ -1 + n))) + (* 18 * x0 * (2 ** (+ -2 + n)))) = 0)
