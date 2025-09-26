regex-018-fuzz-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-fuzz-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "Wwd{aEZ|B)U<8h}B'`Uz?j~K>[NJ@l3\\2~!*wx&)cnixdtF$g")
  Fatal error: exception Failure("TBD")
  TIMEOUT
