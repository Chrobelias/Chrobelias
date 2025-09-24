regex-002-unsat-rotate-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-rotate-translate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "fffkyQZ3-,iakG;naDPJ")
  Fatal error: exception Failure("TBD")
  TIMEOUT
