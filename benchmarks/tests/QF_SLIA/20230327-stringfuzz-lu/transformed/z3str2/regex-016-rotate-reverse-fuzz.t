regex-016-rotate-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-rotate-reverse-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "..l1-5`F!FA*%bawod''\x0c'c'\n'8sPdEv{")
  Fatal error: exception Failure("TBD")
  TIMEOUT
