regex-016-graft-graft-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-graft-graft-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "G&iQG&iQ123")
  Fatal error: exception Failure("TBD")
  TIMEOUT
