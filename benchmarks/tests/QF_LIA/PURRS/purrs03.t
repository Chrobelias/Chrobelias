purrs03
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_LIA/PURRS/purrs03.smt2 || echo TIMEOUT
  Fatal error: exception Failure("expected term, in (div\n                   (none.add\n                    (none.add\n                     (none.add\n                      (none.add (exp a, (none.add n 2))\n                       (exp a, (none.add n 1))) (none.neg (none.mul n n)))\n                     (none.mul\n                      (none.add (none.add (* 2, n, n) (none.mul 2 n))\n                       (none.neg 1)) a))\n                    (none.neg (* (none.add n 1), (none.add n 1), a, a))),\n                   (* (none.sub a 1), (none.sub a 1), (none.sub a 1)))")
  TIMEOUT
