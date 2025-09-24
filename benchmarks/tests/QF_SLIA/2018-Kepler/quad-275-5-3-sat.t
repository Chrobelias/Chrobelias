quad-275-5-3-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-275-5-3-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"abdc\")), x2)),\n                    (str.++ ((str.++ (z1, \"ef\")), z2)))),\n                  (str.++ ((str.++ (t3, (str.++ (t1, t2)))), z3)))) as string")
  TIMEOUT
