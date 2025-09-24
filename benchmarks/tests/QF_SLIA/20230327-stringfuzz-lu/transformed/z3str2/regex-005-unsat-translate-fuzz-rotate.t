regex-005-unsat-translate-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-translate-fuzz-rotate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "Vua.JY)'\\x0c'-D}2]<'\\x0b'.6VV")
  Fatal error: exception Failure("TBD")
  TIMEOUT
