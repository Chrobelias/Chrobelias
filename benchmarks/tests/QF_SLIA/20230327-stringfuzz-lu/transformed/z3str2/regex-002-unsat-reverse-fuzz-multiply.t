regex-002-unsat-reverse-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-reverse-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "ffYYrrffaa]]++kkFF!!UU33xx66QQ**vvaaaaaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
