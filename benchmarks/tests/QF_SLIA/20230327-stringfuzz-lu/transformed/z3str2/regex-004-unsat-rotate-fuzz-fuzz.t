regex-004-unsat-rotate-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-rotate-fuzz-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "'\x0c''\n'lli{Y&NL")
  Fatal error: exception Failure("TBD")
  TIMEOUT
