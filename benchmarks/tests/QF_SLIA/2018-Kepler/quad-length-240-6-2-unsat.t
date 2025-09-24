quad-length-240-6-2-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-240-6-2-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"abdt\")), x2)),\n                    (str.++ ((str.++ (z1, \"ef\")), z2)))),\n                  (str.++ ((str.++ (y1, \"nm\")), y2)))) as string")
  TIMEOUT
