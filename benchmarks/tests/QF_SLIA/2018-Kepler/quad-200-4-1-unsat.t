quad-200-4-1-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-200-4-1-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ ((str.++ ((str.++ (x1, \"deb\")), x2)),\n                  (str.++ (z2, (str.++ (t1, z1)))))) as string")
  TIMEOUT
