regex-006-rotate-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-rotate-reverse-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "cm'\r''\t'ua'\n'%&5")
  Fatal error: exception Failure("TBD")
  TIMEOUT
