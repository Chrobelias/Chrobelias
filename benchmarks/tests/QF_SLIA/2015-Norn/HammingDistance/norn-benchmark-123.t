norn-benchmark-123
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/HammingDistance/norn-benchmark-123.smt2  || echo TIMEOUT
  Not implemented comparison:
  	(= %4 (str.len var_0))
  	(= %6 (str.len var_1))
  Fatal error: exception File "lib/Simpl_alpha.ml", line 50, characters 6-12: Assertion failed
  TIMEOUT
