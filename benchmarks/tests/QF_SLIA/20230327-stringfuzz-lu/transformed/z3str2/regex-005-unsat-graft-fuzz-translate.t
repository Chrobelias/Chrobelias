regex-005-unsat-graft-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-graft-fuzz-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "au[jl'\t'Vkk&+2\\a!u"F%:dwmb_g$$p'l3")
  Fatal error: exception Failure("TBD")
  TIMEOUT
