regex-002-unsat-fuzz-rotate-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-fuzz-rotate-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "kk#:tv>k]d]/nnJ/'yX/='Q9fak")
  Fatal error: exception Failure("TBD")
  TIMEOUT
