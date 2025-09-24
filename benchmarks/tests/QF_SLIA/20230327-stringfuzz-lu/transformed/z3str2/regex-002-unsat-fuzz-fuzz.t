regex-002-unsat-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "YV2{VXaa?k4$q{c{7xyt1p~%'\t'<?N%b'x}2|M")
  Fatal error: exception Failure("TBD")
  TIMEOUT
