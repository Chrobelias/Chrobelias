regex-016-rotate-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-rotate-fuzz-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "0]'-)UfTr""k,D1P$k@""abs'WR!D1'q""31B5@ME;'' ''")
  Fatal error: exception Failure("TBD")
  TIMEOUT
