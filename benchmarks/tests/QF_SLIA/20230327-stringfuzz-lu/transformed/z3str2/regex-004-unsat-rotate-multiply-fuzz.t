regex-004-unsat-rotate-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-rotate-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "~1'!_2-;GbcydE'\t'EclHwc\\!'\x0c'Gd'\x0c'P:Ge")
  Fatal error: exception Failure("TBD")
  TIMEOUT
