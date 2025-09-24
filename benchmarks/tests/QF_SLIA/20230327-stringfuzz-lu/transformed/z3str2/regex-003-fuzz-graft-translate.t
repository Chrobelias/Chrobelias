regex-003-fuzz-graft-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-graft-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "eCQUTaBLnOnFMMmFeKWF?e>9_*C")
  Fatal error: exception Failure("TBD")
  TIMEOUT
