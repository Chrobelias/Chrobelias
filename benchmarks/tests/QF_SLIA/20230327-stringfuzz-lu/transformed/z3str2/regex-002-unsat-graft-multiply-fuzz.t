regex-002-unsat-graft-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-graft-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "qbav>W9ew'\x0b't)@Sh?)J=~gaaa&'\t''\x0c'lkwvv^W_Y>~A>' 'Wa'\n'b'\x0c'^g1?$;$rJPQ:j--SL!tM;<4MT")
  Fatal error: exception Failure("TBD")
  TIMEOUT
