regex-002-unsat-reverse-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-reverse-fuzz-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "I'\x0c'OI$L:'\r'S/J3z6tP*$$$")
  Fatal error: exception Failure("TBD")
  TIMEOUT
