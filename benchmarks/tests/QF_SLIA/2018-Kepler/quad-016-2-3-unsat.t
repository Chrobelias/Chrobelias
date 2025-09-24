quad-016-2-3-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-016-2-3-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ ((str.++ ((str.++ ((str.++ (x7, \"abbc\")), x8)), z)),\n                  x)) as string")
  TIMEOUT
