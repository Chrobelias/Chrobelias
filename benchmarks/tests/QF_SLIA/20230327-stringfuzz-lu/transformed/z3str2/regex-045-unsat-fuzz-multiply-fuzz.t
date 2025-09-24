regex-045-unsat-fuzz-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-045-unsat-fuzz-multiply-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "T%a@x_!LfU}cmy|")
  Fatal error: exception Failure("TBD")
  TIMEOUT
