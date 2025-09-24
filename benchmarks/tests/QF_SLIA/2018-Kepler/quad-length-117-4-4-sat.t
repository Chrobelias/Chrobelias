quad-length-117-4-4-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-117-4-4-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ (\"ab\", z1)),\n                    (str.++ ((str.++ ((str.++ (x1, \"abdc\")), x2)), t1)))),\n                  (str.++ ((str.++ (\"cd\", z2)), (str.++ (t4, t3)))))) as string")
  TIMEOUT
