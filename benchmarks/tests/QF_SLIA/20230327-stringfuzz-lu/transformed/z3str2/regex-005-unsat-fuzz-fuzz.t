regex-005-unsat-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "p'\x0c'A9'aaa?@(35U6+H("zAR+WdtRKkB\\t'@6'\x0c'")
  Fatal error: exception Failure("TBD")
  TIMEOUT
