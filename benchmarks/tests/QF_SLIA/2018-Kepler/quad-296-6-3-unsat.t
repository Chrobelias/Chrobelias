quad-296-6-3-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-296-6-3-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"abcc\")), x2)),\n                    (str.++ ((str.++ (z1, t3)), z2)))),\n                  (str.++ ((str.++ (y1, t1)), y2)))) as string")
  TIMEOUT
