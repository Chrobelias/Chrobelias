quad-length-063-4-0-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-063-4-0-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++ ((str.++ (\"ab\", z1)), (str.++ (\"fe\", z2)))),\n                    (str.++ (x1, \"abfe\")))), x2)) as string")
  TIMEOUT
