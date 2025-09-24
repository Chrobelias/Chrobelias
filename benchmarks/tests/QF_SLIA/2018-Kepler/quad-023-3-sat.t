quad-023-3-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-023-3-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ ((str.++ ((str.++ (x1, \"abdc\")), x2)),\n                  (str.++ (x3, \"ab\")))) as string")
  TIMEOUT
