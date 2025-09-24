500
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/2019-full_str_int/py-conbyte_z3str/leetcode_int-restoreIpAddresses/500.smt2  || echo TIMEOUT
  Fatal error: exception Failure("Expression (str.prefixof \"-\"\n            (str.substr s 1 (none.sub (none.add 1 (none.add 1 1)) 1))) can't be handled")
  TIMEOUT
