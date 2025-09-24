regex-016-translate-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-translate-rotate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "QnF{t9WN0*#1p$:cih'\x0c'EGojT#EhfB2")
  Fatal error: exception Failure("TBD")
  TIMEOUT
