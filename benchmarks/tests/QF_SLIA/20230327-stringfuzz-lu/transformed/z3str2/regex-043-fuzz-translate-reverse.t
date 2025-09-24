regex-043-fuzz-translate-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-043-fuzz-translate-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "i'r\\'U{")
  Fatal error: exception Failure("TBD")
  TIMEOUT
