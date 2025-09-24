regex-004-unsat-rotate-multiply-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-rotate-multiply-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "'\x0c''\x0c'MMssccsscc!!")
  Fatal error: exception Failure("TBD")
  TIMEOUT
