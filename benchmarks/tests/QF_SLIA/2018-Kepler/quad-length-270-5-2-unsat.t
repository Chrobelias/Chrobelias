quad-length-270-5-2-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-270-5-2-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"abde\")), x2)),\n                    (str.++ ((str.++ (z1, t1)), z2)))), (str.++ (\"mn\", z3)))) as string")
  TIMEOUT
