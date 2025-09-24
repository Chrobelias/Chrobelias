regex-018-graft-rotate-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-graft-rotate-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "123<t")
  Fatal error: exception Failure("TBD")
  TIMEOUT
