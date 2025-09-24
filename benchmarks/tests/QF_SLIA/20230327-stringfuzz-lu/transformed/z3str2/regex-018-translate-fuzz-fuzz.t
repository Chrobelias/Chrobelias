regex-018-translate-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-translate-fuzz-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "t}d!y]~['Iu'\r'/'\r''<f' '+~w3cmB")
  Fatal error: exception Failure("TBD")
  TIMEOUT
