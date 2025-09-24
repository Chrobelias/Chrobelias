regex-005-unsat-translate-fuzz-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-translate-fuzz-graft.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "Vua.JY)'\\x0c'-D}2]<'\\x0b'.6VV")
  Fatal error: exception Failure("TBD")
  TIMEOUT
