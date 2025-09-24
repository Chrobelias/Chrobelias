quad-length-132-4-2-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-132-4-2-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++ ((str.++ ((str.++ (x1, \"abec\")), x2)), t2)),\n                    (str.++ (\"ab\", z1)))), (str.++ (\"cd\", z2)))) as string")
  TIMEOUT
