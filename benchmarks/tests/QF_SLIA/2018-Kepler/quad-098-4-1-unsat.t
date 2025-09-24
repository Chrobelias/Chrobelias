quad-098-4-1-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-098-4-1-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ (\"ab\", z1)),\n                    (str.++ ((str.++ (x1, \"abdc\")), x2)))),\n                  (str.++ ((str.++ (\"cd\", z2)), \"bb\")))) as string")
  TIMEOUT
