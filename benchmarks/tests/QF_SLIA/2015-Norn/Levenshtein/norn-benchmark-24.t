norn-benchmark-24
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/Levenshtein/norn-benchmark-24.smt2  || echo TIMEOUT
  Not implemented comparison:
  	(= %3 (str.len var_0))
  	(= %5 (str.len var_1))
  Fatal error: exception File "lib/Simpl_alpha.ml", line 50, characters 6-12: Assertion failed
  TIMEOUT
