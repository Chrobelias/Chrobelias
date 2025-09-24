regex-005-unsat-multiply-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-multiply-reverse-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "'\x0c'~}f*'\t'2a'wZ^ramq'\t'm?i5>yARNnW).3Aaaaaa/@!@@/' 'aaanA9$-)")
  Fatal error: exception Failure("TBD")
  TIMEOUT
