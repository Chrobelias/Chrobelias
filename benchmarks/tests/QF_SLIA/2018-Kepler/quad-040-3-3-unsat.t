quad-040-3-3-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-040-3-3-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++\n                    ((str.++ ((str.++ (\"ab\", z)), (str.++ (x1, \"addc\")))),\n                    x2)), (str.++ (t2, t3)))) as string")
  TIMEOUT
