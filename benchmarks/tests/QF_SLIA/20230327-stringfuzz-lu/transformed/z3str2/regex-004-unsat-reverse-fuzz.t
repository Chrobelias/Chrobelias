regex-004-unsat-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-reverse-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "o=KJ'\x0b'3~`ldc:\\")
  Fatal error: exception Failure("TBD")
  TIMEOUT
