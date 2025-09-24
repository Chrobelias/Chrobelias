quad-length-177-4-3-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-177-4-3-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ ((str.++ ((str.++ (x1, \"dcb\")), x2)),\n                  (str.++ (t2,\n                   (str.++ ((str.++ (z2, (str.++ (\"abf\", z1)))), t1)))))) as string")
  TIMEOUT
