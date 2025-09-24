regex-016-translate-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-translate-fuzz-reverse.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "31=dUPR'b0x\\''b0x\\'g10'' '''t\\'Zq#I|F""'b0x\\'u0.VJVh'' ''D(gML")
  Fatal error: exception Failure("TBD")
  TIMEOUT
