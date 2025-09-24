quad-133-4-2-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-133-4-2-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++ ((str.++ ((str.++ (x1, \"abdc\")), x2)), \"cb\")),\n                    (str.++ (t2, (str.++ (\"ab\", z1)))))),\n                  (str.++ (\"cd\", z2)))) as string")
  TIMEOUT
