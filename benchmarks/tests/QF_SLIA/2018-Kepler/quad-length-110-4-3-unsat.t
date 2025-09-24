quad-length-110-4-3-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-110-4-3-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (\"ab\", z1)), \"a\")),\n                    (str.++ ((str.++ (x1, \"abdc\")), x2)))),\n                  (str.++ ((str.++ (\"cd\", z2)), t3)))) as string")
  TIMEOUT
