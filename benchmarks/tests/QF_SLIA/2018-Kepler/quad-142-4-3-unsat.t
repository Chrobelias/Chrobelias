quad-142-4-3-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-142-4-3-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"abdc\")), x2)),\n                    (str.++ (\"ac\", z1)))),\n                  (str.++ ((str.++ (\"rd\", z2)), (str.++ (t3, t2)))))) as string")
  TIMEOUT
