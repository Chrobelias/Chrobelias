regex-016-translate-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-translate-reverse-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "n<UYtRx0{Nz'\r''\r'88.Ee/Q'\r'w|SB")
  Fatal error: exception Failure("TBD")
  TIMEOUT
