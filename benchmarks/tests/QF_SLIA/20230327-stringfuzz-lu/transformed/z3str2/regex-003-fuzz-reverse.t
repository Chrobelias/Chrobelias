regex-003-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-reverse.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "ejgaa+m't\\'?%q6U(ocJ1xA'c0x\\'-=k2'Z'r\\'|+d@mb9I")
  Fatal error: exception Failure("TBD")
  TIMEOUT
