regex-043-multiply-reverse-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-043-multiply-reverse-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aaaaaaaaaaaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
