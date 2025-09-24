quad-length-135-4-2-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-135-4-2-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"abdc\")), x2)),\n                    (str.++ ((str.++ (\"ab\", z1)), t2)))),\n                  (str.++ (\"cd\", z2)))) as string")
  TIMEOUT
