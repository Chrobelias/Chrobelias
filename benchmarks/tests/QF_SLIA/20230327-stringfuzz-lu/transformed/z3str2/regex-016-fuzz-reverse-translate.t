regex-016-fuzz-reverse-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-reverse-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "N4%z%1@nR[yDhx~H@DL@J`+' 'n'\t'ql=z8C' '")
  Fatal error: exception Failure("TBD")
  TIMEOUT
