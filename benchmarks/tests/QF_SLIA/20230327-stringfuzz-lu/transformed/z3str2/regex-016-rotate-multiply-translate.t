regex-016-rotate-multiply-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-rotate-multiply-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "GG%%LLRRGG%%LLRR112233")
  Fatal error: exception Failure("TBD")
  TIMEOUT
