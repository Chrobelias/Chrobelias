regex-006-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-multiply-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aab5/'\x0b'v`}BmdzW\\cc")
  Fatal error: exception Failure("TBD")
  TIMEOUT
