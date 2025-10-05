norn-benchmark-35
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/HammingDistance/norn-benchmark-35.smt2  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception File "lib/SimplII.ml", line 181, characters 11-17: Assertion failed
  TIMEOUT
