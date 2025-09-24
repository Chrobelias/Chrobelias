quad-260-4-5-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-260-4-5-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"abdc\")), x2)),\n                    (str.++ ((str.++ (z1, \"ee\")), z2)))),\n                  (str.++ ((str.++ (y1, (str.++ ((str.++ (t1, t2)), t5)))),\n                   y2)))) as string")
  TIMEOUT
