regex-005-unsat-graft-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-graft-fuzz-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aa~~%%OOwwHHpp\\\\\\\\]]//22ttaaDD~~}}IIdd||nn@@PPffeeJJ""""<<((ww33")
  Fatal error: exception Failure("TBD")
  TIMEOUT
