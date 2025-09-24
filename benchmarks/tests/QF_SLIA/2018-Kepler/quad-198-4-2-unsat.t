quad-198-4-2-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-198-4-2-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ (\"ae\", z1)),\n                    (str.++ ((str.++ (x1, \"abdc\")), x2)))),\n                  (str.++ (t1, z2)))) as string")
  TIMEOUT
