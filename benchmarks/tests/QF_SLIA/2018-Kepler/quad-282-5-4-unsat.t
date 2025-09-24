quad-282-5-4-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-282-5-4-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"ardc\")), x2)),\n                    (str.++ ((str.++ (z1, t3)), z2)))),\n                  (str.++ ((str.++ (t1, t2)), z3)))) as string")
  TIMEOUT
