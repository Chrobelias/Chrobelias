regex-006-translate-translate-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-translate-translate-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "!'\\r''\\t'ZL0F'\\t'!'\\r''\\t'ZL0F'\\t'")
  Fatal error: exception Failure("TBD")
  TIMEOUT
