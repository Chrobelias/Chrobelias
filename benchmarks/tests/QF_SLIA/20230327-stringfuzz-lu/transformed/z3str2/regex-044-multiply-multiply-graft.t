regex-044-multiply-multiply-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-044-multiply-multiply-graft.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "7777")
  Fatal error: exception Failure("TBD")
  TIMEOUT
