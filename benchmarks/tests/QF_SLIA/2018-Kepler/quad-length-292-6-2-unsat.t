quad-length-292-6-2-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-292-6-2-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"atdc\")), x2)),\n                    (str.++ ((str.++ (z1, t1)), z2)))),\n                  (str.++ ((str.++ (y1, \"mn\")), y2)))) as string")
  TIMEOUT
