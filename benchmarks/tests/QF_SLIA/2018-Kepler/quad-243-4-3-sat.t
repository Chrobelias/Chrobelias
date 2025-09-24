quad-243-4-3-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-243-4-3-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"ab\")), x2)),\n                    (str.++ ((str.++ (z1, \"ef\")), z2)))),\n                  (str.++ ((str.++ (y1, t2)), y2)))) as string")
  TIMEOUT
