regex-002-unsat-fuzz-translate-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-fuzz-translate-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "vvvvAAKKVVvvvv~~ee44rrhhLLiiww00DDLLLLDD;;..44")
  Fatal error: exception Failure("TBD")
  TIMEOUT
