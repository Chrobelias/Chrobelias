regex-020-fuzz-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-020-fuzz-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "ccKKLLCC]]\\\\\\\\__vvGGYYTT!!UU))++")
  Fatal error: exception Failure("TBD")
  TIMEOUT
