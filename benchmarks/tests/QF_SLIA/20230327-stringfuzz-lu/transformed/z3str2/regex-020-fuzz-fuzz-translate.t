regex-020-fuzz-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-020-fuzz-fuzz-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "P-' 'j(GG}q{~^/Kg*")
  Fatal error: exception Failure("TBD")
  TIMEOUT
