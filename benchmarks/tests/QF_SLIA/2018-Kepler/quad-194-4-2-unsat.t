quad-194-4-2-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-194-4-2-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++ ((str.++ (\"bb\", z1)), (str.++ (\"cd\", z2)))),\n                    (str.++ (x1, \"abdc\")))), x2)) as string")
  TIMEOUT
