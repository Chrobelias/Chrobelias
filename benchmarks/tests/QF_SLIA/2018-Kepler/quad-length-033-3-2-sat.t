quad-length-033-3-2-sat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-033-3-2-sat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ (\"bacd\", z)),\n                    (str.++ ((str.++ (x1, \"ab\")), x2)))), t2)) as string")
  TIMEOUT
