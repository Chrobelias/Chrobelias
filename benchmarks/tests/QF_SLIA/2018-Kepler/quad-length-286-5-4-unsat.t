quad-length-286-5-4-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-length-286-5-4-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"abdt\")), x2)),\n                    (str.++ ((str.++ (z1, t3)), z2)))), (str.++ (\"db\", z3)))) as string")
  TIMEOUT
