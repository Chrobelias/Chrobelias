norn-benchmark-2
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/Levenshtein/norn-benchmark-2.smt2  || echo TIMEOUT
  Not implemented comparison:
  	(= %11 (str.len var_3))
  	(= %7 (str.len var_2))
  Fatal error: exception File "lib/Simpl_alpha.ml", line 50, characters 6-12: Assertion failed
  TIMEOUT
