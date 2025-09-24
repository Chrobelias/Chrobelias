regex-005-unsat-reverse-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-reverse-multiply-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "tkGfgFgX%j?{3'\x0c'm'\t'!E=`.1fXPMs%3Z_pEtyDNRgYdU4a0~(W^h:^['\x0b'aW-aaaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
