regex-016-fuzz-translate-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-translate-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "hn(va=XXZ~jCjs(75hn'\t'r/K,KB11x'\x0b'HjGcj")
  Fatal error: exception Failure("TBD")
  TIMEOUT
