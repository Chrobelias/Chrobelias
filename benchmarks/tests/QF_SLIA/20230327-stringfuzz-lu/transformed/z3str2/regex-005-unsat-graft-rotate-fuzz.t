regex-005-unsat-graft-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-graft-rotate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "Kk=iRXC{AJ9wEwU|ezN}s)SgMU,O")
  Fatal error: exception Failure("TBD")
  TIMEOUT
