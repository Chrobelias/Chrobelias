quad-046-3-6-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-046-3-6-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++ ((str.++ (\"aa\", z)), (str.++ (x1, \"abdc\")))),\n                    x2)), (str.++ (t2, (str.++ (t6, t3)))))) as string")
  TIMEOUT
