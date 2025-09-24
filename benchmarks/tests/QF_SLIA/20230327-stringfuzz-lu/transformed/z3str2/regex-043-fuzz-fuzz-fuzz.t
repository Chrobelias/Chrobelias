regex-043-fuzz-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-043-fuzz-fuzz-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "j8Qe}=r'\x0c'")
  Fatal error: exception Failure("TBD")
  TIMEOUT
