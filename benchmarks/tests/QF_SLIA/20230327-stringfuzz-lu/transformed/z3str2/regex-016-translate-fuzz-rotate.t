regex-016-translate-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-translate-fuzz-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "LMg(D'' ''hVJV.0u'\\x0b'""F|I#qZ'\\t''' ''01g'\\x0b''\\x0b'RPUd=13")
  Fatal error: exception Failure("TBD")
  TIMEOUT
