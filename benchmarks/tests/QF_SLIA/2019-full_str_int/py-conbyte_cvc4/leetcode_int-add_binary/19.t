19
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_cvc4/leetcode_int-add_binary/19.smt2  || echo TIMEOUT
  Fatal error: exception Failure("Expression (str.prefixof \"-\"\n            (str.at b (none.add (str.length b) (none.neg 1)))) can't be handled")
  TIMEOUT
