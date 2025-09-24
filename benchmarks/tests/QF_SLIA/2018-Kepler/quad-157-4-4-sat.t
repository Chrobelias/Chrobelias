quad-157-4-4-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-157-4-4-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++ ((str.++ ((str.++ (x1, \"abdc\")), x2)),\n                      (str.++ (t3, t1)))),\n                    (str.++ ((str.++ (\"ab\", z1)), t4)))),\n                  (str.++ (\"cd\", z2)))) as string")
  TIMEOUT
