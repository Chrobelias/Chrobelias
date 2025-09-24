quad-036-3-2-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-036-3-2-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ (\"ab\", z)),\n                    (str.++ ((str.++ (x1, \"abvv\")), x2)))), t2)) as string")
  TIMEOUT
