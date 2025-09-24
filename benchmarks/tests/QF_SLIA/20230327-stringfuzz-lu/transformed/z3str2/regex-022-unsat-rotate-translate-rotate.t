regex-022-unsat-rotate-translate-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-022-unsat-rotate-translate-rotate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "@'\\x0c'")
  Fatal error: exception Failure("TBD")
  TIMEOUT
