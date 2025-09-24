quad-001-1-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-001-1-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (\"ab\", x)) as string")
  TIMEOUT
