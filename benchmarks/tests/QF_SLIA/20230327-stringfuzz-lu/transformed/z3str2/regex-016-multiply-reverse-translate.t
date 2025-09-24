regex-016-multiply-reverse-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-multiply-reverse-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "332211::==~~'\x0c''\x0c'::==~~'\x0c''\x0c'")
  Fatal error: exception Failure("TBD")
  TIMEOUT
