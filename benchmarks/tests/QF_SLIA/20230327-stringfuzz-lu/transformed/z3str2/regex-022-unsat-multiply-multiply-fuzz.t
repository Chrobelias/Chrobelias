regex-022-unsat-multiply-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-022-unsat-multiply-multiply-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "XT1Ime#Ad1h}*xE:|S:}Xi>rcRe8C%b")
  Fatal error: exception Failure("TBD")
  TIMEOUT
