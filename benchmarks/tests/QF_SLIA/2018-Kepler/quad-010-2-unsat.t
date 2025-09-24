quad-010-2-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-010-2-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (\"abx\", (str.++ ((str.++ (x312, \"abbc\")), x429)))) as string")
  TIMEOUT
