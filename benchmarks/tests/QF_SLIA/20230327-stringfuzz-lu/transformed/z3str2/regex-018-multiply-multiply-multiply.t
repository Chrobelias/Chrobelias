regex-018-multiply-multiply-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-multiply-multiply-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "111111112222222233333333AAAAAAAABBBBBBBB")
  Fatal error: exception Failure("TBD")
  TIMEOUT
