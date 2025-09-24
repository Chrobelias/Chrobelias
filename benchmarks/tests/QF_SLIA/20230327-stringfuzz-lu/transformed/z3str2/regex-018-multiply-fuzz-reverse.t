regex-018-multiply-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-multiply-fuzz-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x ",8JjA'' ''T>}*v5j<V^-'r\\'>;%F@gY=")
  Fatal error: exception Failure("TBD")
  TIMEOUT
