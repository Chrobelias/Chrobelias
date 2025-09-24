norn-benchmark-6
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/Levenshtein/norn-benchmark-6.smt2  || echo TIMEOUT
  Not implemented comparison:
  	((-1%1 <= -1) & (1%1 + -1%4 = 0))
  	(= %5 (str.len var_1))
  Fatal error: exception File "lib/Simpl_alpha.ml", line 50, characters 6-12: Assertion failed
  TIMEOUT
