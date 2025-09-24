quad-length-227-5-5-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-227-5-5-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"abdc\")), x2)),\n                    (str.++ ((str.++ (z1, \"ba\")), z2)))),\n                  (str.++ ((str.++ (t5, t1)), z3)))) as string")
  TIMEOUT
