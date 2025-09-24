quad-length-160-4-4-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-160-4-4-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++ ((str.++ ((str.++ (x1, \"ablc\")), x2)), t1)),\n                    (str.++ ((str.++ (\"ab\", z1)), t4)))),\n                  (str.++ (\"cd\", z2)))) as string")
  TIMEOUT
