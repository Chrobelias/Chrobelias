quad-145-4-3-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-145-4-3-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"abdc\")), x2)),\n                    (str.++ ((str.++ (\"ab\", z1)), (str.++ (t1, t3)))))),\n                  (str.++ (\"cd\", z2)))) as string")
  TIMEOUT
