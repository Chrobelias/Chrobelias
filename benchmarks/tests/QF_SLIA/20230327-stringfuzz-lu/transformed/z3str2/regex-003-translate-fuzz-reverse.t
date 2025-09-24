regex-003-translate-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-translate-fuzz-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "(""&*9R'{OEzOh""'n\\'qEkcmk3\\\\Td1=iJ1<!S`'r\\'|+|0'N\\\\\\\\")
  Fatal error: exception Failure("TBD")
  TIMEOUT
