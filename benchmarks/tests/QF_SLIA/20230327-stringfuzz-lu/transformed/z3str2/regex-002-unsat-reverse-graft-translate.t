regex-002-unsat-reverse-graft-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-reverse-graft-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "PPPPPPPPP")
  Fatal error: exception Failure("TBD")
  TIMEOUT
