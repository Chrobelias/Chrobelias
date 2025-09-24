regex-002-unsat-translate-reverse-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-translate-reverse-rotate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "wwwwwwwww")
  Fatal error: exception Failure("TBD")
  TIMEOUT
