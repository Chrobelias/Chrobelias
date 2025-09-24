regex-006-fuzz-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-fuzz-fuzz-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "bnK]fr5&p@7-IhBeVYn4IRQl:@a'\x0c''\n'(4bW_n1G$Ah<te0")
  Fatal error: exception Failure("TBD")
  TIMEOUT
