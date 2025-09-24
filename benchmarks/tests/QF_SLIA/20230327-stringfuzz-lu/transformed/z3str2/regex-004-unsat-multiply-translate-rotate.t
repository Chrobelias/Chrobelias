regex-004-unsat-multiply-translate-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-multiply-translate-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "hh~~bb'\\r''\\r'bb'\\r''\\r''\\x0b''\\x0b'")
  Fatal error: exception Failure("TBD")
  TIMEOUT
