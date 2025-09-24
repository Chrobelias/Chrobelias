regex-005-unsat-translate-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-translate-fuzz-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "VVuuaa..JJYY))''\\\\xx00cc''--DD}}22]]<<''\\\\xx00bb''..66VVVV")
  Fatal error: exception Failure("TBD")
  TIMEOUT
