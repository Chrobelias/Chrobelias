quad-length-126-4-1-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-126-4-1-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"abde\")), x2)),\n                    (str.++ ((str.++ (\"ab\", z1)), \"ef\")))),\n                  (str.++ (\"cd\", z2)))) as string")
  TIMEOUT
