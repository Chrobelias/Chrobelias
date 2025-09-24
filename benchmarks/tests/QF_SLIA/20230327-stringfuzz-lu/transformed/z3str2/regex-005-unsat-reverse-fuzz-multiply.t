regex-005-unsat-reverse-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-reverse-fuzz-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aa((SS991166aaaaqqee<<''\\\\rr''||__ee{{11''\\\\xx00bb''66MMff")
  Fatal error: exception Failure("TBD")
  TIMEOUT
