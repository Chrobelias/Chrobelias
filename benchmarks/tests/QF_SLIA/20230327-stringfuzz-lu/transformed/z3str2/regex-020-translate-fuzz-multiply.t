regex-020-translate-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-020-translate-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "''%%''\\\\xx00cc''9966EEEE((ff""""""""))PP")
  Fatal error: exception Failure("TBD")
  TIMEOUT
