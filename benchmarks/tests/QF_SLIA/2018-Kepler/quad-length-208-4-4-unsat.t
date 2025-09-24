quad-length-208-4-4-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-208-4-4-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ ((str.++ ((str.++ (x1, \"ecb\")), x2)),\n                  (str.++ (z2, (str.++ ((str.++ (t2, t1)), z1)))))) as string")
  TIMEOUT
