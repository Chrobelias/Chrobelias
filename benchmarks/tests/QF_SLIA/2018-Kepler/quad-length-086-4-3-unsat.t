quad-length-086-4-3-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-086-4-3-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++\n                      ((str.++ ((str.++ ((str.++ (\"ab\", z1)), t2)),\n                        (str.++ (\"dd\", z2)))), (str.++ (x1, \"abdc\")))), \n                    x2)), t3)) as string")
  TIMEOUT
