regex-016-graft-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-graft-translate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "Nn*,pjK'\x0c'pQ(T'Y+'?RC%.6ouL3i_P7?YuwoGC2M9' ''\x0c'u('' ''R/op3&cyY'\x0b']'\x0c'DV'\t'/]2fT!")
  Fatal error: exception Failure("TBD")
  TIMEOUT
