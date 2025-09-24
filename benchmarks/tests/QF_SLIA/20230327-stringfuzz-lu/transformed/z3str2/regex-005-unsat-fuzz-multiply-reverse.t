regex-005-unsat-fuzz-multiply-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-fuzz-multiply-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aaGG^^99~~cc{{''ww<<cc''nn\\\\\\\\''hhAAhhaaZZCCPP!!$$aaaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
