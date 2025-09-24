regex-003-translate-translate-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-translate-translate-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "QQ{{CCNNAAQQ{{QQ{{CC")
  Fatal error: exception Failure("TBD")
  TIMEOUT
