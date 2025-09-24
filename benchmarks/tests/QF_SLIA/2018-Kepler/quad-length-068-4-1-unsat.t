quad-length-068-4-1-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-068-4-1-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++ ((str.++ (t1, (str.++ (\"ab\", z1)))),\n                      (str.++ (\"cd\", z2)))), (str.++ (x1, \"abdc\")))), \n                  x2)) as string")
  TIMEOUT
