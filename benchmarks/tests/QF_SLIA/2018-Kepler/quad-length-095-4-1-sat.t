quad-length-095-4-1-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-095-4-1-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ (\"ab\", z1)),\n                    (str.++ ((str.++ ((str.++ (x1, \"abdc\")), x2)), t1)))),\n                  (str.++ (\"cd\", z2)))) as string")
  TIMEOUT
