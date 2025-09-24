22
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_cvc4/leetcode_int-add_binary/22.smt2  || echo TIMEOUT
  Not implemented comparison:
  	(exists (%0) ((1%0 + -1%1 = 0) & ~(-1%0 <= -1)))
  	(= %2 (str.len a))
  Fatal error: exception File "lib/Simpl_alpha.ml", line 50, characters 6-12: Assertion failed
  TIMEOUT
