regex-016-reverse-reverse-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-reverse-reverse-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x ">-^P>-^P123")
  Fatal error: exception Failure("TBD")
  TIMEOUT
