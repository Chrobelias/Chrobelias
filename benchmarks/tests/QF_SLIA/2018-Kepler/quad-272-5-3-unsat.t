quad-272-5-3-unsat
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../benchmarks/QF_SLIA/2018-Kepler/quad-272-5-3-unsat.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++\n                  ((str.++ ((str.++ ((str.++ (x1, \"abtc\")), x2)),\n                    (str.++ ((str.++ (z1, t1)), z2)))), (str.++ (t3, z3)))) as string")
  TIMEOUT
