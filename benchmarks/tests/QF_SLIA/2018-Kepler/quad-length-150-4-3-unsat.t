quad-length-150-4-3-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-150-4-3-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++ ((str.++ ((str.++ (x1, \"abec\")), x2)),\n                      (str.++ (t3, t1)))), (str.++ (\"ab\", z1)))),\n                  (str.++ (\"cd\", z2)))) as string")
  TIMEOUT
