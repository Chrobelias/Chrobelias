quad-134-4-2-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-134-4-2-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++ ((str.++ ((str.++ (x1, \"abec\")), x2)), \"cb\")),\n                    (str.++ (t2, (str.++ (\"ab\", z1)))))),\n                  (str.++ (\"cd\", z2)))) as string")
  TIMEOUT
