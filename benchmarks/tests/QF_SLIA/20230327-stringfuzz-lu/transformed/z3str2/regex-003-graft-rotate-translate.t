regex-003-graft-rotate-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-graft-rotate-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "M'\x0c'<'+M'\x0c'M'\x0c'<")
  Fatal error: exception Failure("TBD")
  TIMEOUT
