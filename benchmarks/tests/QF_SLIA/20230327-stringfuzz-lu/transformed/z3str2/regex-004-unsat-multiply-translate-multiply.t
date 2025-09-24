regex-004-unsat-multiply-translate-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-multiply-translate-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "hhhh~~~~bbbb''\\\\rr''''\\\\rr''bbbb''\\\\rr''''\\\\rr''''\\\\xx00bb''''\\\\xx00bb''")
  Fatal error: exception Failure("TBD")
  TIMEOUT
