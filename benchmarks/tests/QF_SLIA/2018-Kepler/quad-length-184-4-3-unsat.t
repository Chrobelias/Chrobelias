quad-length-184-4-3-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-184-4-3-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ ((str.++ ((str.++ (x1, \"acb\")), x2)),\n                  (str.++ (t2,\n                   (str.++ ((str.++ (z2, (str.++ (\"abf\", z1)))), t1)))))) as string")
  TIMEOUT
