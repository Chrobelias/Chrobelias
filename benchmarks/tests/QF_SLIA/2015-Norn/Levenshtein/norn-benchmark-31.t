norn-benchmark-31
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/Levenshtein/norn-benchmark-31.smt2  || echo TIMEOUT
  Not implemented comparison:
  	((-1%0 <= -1) & (1%0 <= 1) & (1%0 + -1%5 = 0))
  	(= %10 (str.len var_4))
  Fatal error: exception File "lib/Simpl_alpha.ml", line 50, characters 6-12: Assertion failed
  TIMEOUT
