quad-length-017-2-4-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-017-2-4-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ ((str.++ ((str.++ ((str.++ (x7, \"abbc\")), x8)), z)),\n                  (str.++ (x1, x2)))) as string")
  TIMEOUT
