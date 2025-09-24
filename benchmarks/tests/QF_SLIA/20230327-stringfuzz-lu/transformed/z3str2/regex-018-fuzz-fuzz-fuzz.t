regex-018-fuzz-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-fuzz-fuzz-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "J1H9\\s^1[K8)X[X'\x0b';U@4^:ZnL")
  Fatal error: exception Failure("TBD")
  TIMEOUT
