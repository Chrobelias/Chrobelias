regex-016-fuzz-rotate-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-rotate-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "aa{{88oo++ssuuVVbbaaEE$$!!ddCC))ddGG((qq::))..AAUUbbdd11nnoonn44;;")
  Fatal error: exception Failure("TBD")
  TIMEOUT
