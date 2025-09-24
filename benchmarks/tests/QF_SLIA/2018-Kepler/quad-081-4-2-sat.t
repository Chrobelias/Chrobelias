quad-081-4-2-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-081-4-2-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++ ((str.++ ((str.++ (\"ab\", z1)), t2)),\n                      (str.++ ((str.++ (\"cd\", z2)), t1)))),\n                    (str.++ (x1, \"abdc\")))), x2)) as string")
  TIMEOUT
