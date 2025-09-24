norn-benchmark-69
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/ab/norn-benchmark-69.smt2  || echo TIMEOUT
  Not implemented comparison:
  	(= %2 (str.len var_0))
  	(-1%0 + 2v = 2)
  Fatal error: exception File "lib/Simpl_alpha.ml", line 50, characters 6-12: Assertion failed
  TIMEOUT
