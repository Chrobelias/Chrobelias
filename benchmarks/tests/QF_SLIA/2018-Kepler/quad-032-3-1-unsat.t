quad-032-3-1-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-032-3-1-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ ((str.++ (\"bacd\", z)),\n                  (str.++ ((str.++ (x1, \"abc\")), x2)))) as string")
  TIMEOUT
