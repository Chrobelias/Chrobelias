quad-256-4-4-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-256-4-4-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"abdc\")), x2)),\n                    (str.++ ((str.++ (z1, \"af\")), z2)))),\n                  (str.++ ((str.++ (y1, (str.++ (t3, (str.++ (t1, t2)))))),\n                   y2)))) as string")
  TIMEOUT
