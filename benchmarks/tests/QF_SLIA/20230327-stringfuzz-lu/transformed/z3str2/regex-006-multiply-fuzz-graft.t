regex-006-multiply-fuzz-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-multiply-fuzz-graft.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "a^bcaahccd=bEO>c=v3b>bK,]s7+")
  Fatal error: exception Failure("TBD")
  TIMEOUT
