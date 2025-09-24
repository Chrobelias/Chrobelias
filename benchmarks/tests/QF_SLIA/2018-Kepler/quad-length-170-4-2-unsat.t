quad-length-170-4-2-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-170-4-2-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ ((str.++ ((str.++ (x1, \"dcl\")), x2)),\n                  (str.++\n                   ((str.++ (t1, (str.++ (z2, (str.++ (\"abf\", z1)))))), \n                   t2)))) as string")
  TIMEOUT
