regex-016-rotate-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-rotate-fuzz-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "00]]''--))UUffTTrr""""kk,,DD11PP$$kk@@""""aabbss''WWRR!!DD11''qq""""3311BB55@@MMEE;;''' '' '''")
  Fatal error: exception Failure("TBD")
  TIMEOUT
