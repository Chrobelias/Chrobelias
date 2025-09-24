regex-002-unsat-multiply-multiply-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-multiply-multiply-rotate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
