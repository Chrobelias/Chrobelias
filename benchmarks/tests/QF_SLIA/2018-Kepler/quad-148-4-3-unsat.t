quad-148-4-3-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-148-4-3-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++ ((str.++ ((str.++ (x1, \"cbdc\")), x2)), t1)),\n                    (str.++ ((str.++ (\"ab\", z1)), t3)))),\n                  (str.++ (\"cd\", z2)))) as string")
  TIMEOUT
