quad-length-197-4-2-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-197-4-2-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ (\"ab\", z1)),\n                    (str.++ ((str.++ (x1, \"abdc\")), x2)))),\n                  (str.++ (t1, z2)))) as string")
  TIMEOUT
