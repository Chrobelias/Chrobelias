regex-002-unsat-graft-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-graft-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aa||ZZ}}``<<99--TT22::EEvvMMee11aaaaaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
