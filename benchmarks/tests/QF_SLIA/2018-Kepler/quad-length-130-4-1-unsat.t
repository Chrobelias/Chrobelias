quad-length-130-4-1-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-130-4-1-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++ (t1, (str.++ ((str.++ (x1, \"acdc\")), x2)))),\n                    (str.++ (\"ac\", z1)))), (str.++ (\"cd\", z2)))) as string")
  TIMEOUT
