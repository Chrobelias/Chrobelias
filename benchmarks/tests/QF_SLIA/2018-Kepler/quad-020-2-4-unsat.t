quad-020-2-4-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-020-2-4-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x7, \"abbbc\")), x8)), z)), \n                  x2)) as string")
  TIMEOUT
