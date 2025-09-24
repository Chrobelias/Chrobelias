quad-length-076-4-2-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-076-4-2-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++\n                      ((str.++ ((str.++ (\"ab\", z1)), (str.++ (\"dd\", z2)))),\n                      (str.++ (x1, \"abdc\")))), x2)), t2)) as string")
  TIMEOUT
