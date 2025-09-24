regex-018-multiply-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-multiply-fuzz-rotate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "=Yg@F%;>'\\r'-^V<j5v*}>T'' ''AjJ8,")
  Fatal error: exception Failure("TBD")
  TIMEOUT
