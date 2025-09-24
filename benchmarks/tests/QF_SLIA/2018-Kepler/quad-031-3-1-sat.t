quad-031-3-1-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-031-3-1-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ ((str.++ (\"bacd\", z)),\n                  (str.++ ((str.++ (x1, \"ab\")), x2)))) as string")
  TIMEOUT
