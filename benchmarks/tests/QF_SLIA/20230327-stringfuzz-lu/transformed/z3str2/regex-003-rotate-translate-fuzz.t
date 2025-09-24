regex-003-rotate-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-rotate-translate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "|</b:GdFtmqlc&T4B4|G}Od3`O@S@")
  Fatal error: exception Failure("TBD")
  TIMEOUT
