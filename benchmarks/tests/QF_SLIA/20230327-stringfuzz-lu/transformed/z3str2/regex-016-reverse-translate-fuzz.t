regex-016-reverse-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-reverse-translate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "32pXI-BHBR9[g' 'Z5D@_uS7'\x0c'U'~'g8$pH'[P'~]rR<x2ja4\\<X~'\x0c'/&4'WO+,hpLb'\r',U*2<k4qD$!4Km']:&z"~0iH*Z")
  Fatal error: exception Failure("TBD")
  TIMEOUT
