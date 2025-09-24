quad-118-4-4-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-118-4-4-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ (\"ab\", z1)),\n                    (str.++ ((str.++ ((str.++ (x1, \"acdc\")), x2)), t1)))),\n                  (str.++ ((str.++ (\"cd\", z2)), (str.++ (t4, t3)))))) as string")
  TIMEOUT
