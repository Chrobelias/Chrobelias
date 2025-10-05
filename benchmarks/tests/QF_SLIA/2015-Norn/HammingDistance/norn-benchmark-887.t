norn-benchmark-887
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/HammingDistance/norn-benchmark-887.smt2  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception File "lib/SimplII.ml", line 181, characters 11-17: Assertion failed
  TIMEOUT
