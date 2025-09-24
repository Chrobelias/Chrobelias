regex-003-fuzz-reverse-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-reverse-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "|?%9nQa,'\t'_Q,:cc,/s/tC@kjq|Q")
  Fatal error: exception Failure("TBD")
  TIMEOUT
