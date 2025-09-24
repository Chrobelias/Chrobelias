quad-059-3-7-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-059-3-7-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++ ((str.++ (\"ab\", z)), (str.++ (x1, \"abdc\")))),\n                    x2)),\n                  (str.++ ((str.++ (t6, (str.++ (t1, t3)))),\n                   (str.++ ((str.++ (t7, t5)), (str.++ (t2, t4)))))))) as string")
  TIMEOUT
