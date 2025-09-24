quad-058-3-7-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-058-3-7-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ (\"ab\", z)), (str.++ (x1, \"abdc\")))), \n                  x2)) as string")
  TIMEOUT
