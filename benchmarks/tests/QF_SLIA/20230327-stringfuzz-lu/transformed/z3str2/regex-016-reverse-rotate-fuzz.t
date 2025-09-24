regex-016-reverse-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-reverse-rotate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "2@]dbU7oMdc7%g^KMnUTa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
