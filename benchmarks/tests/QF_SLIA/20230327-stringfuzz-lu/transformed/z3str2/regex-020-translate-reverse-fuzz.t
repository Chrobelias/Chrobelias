regex-020-translate-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-020-translate-reverse-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "'\x0c')oRmE%im\\\\"w~#'\n'M\\m6d$hk'\x0c'LR;QL")
  Fatal error: exception Failure("TBD")
  TIMEOUT
