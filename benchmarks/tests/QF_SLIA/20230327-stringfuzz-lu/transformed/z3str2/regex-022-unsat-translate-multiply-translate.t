regex-022-unsat-translate-multiply-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-022-unsat-translate-multiply-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "II'\x0b''\x0b'")
  Fatal error: exception Failure("TBD")
  TIMEOUT
