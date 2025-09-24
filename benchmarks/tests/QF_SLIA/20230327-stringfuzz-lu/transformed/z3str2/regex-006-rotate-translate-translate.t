regex-006-rotate-translate-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-rotate-translate-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x ">NBa0$N:>NBa0$N:")
  Fatal error: exception Failure("TBD")
  TIMEOUT
