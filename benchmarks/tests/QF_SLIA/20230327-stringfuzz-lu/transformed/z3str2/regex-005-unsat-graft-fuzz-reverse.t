regex-005-unsat-graft-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-graft-fuzz-reverse.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "3w(<""JefP@n|dI}~Dat2/]\\\\pHwO%~a")
  Fatal error: exception Failure("TBD")
  TIMEOUT
