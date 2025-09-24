regex-045-unsat-reverse-multiply-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-045-unsat-reverse-multiply-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x ";;nn'\x0c''\x0c'")
  Fatal error: exception Failure("TBD")
  TIMEOUT
