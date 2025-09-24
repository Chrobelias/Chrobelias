regex-004-unsat-rotate-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-rotate-translate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "td7#eczIZvcm'\t''PtU'\t's_['\n''\x0c'yE'\\nW")
  Fatal error: exception Failure("TBD")
  TIMEOUT
