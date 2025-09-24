regex-016-multiply-multiply-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-multiply-multiply-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "aaaabbbbccccddddaaaabbbbccccdddd111122223333")
  Fatal error: exception Failure("TBD")
  TIMEOUT
