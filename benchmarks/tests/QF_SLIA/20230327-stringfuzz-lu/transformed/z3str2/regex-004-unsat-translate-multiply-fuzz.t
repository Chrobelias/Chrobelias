regex-004-unsat-translate-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-translate-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "6.'\\gpAIc(@]=h*<@avnuV1CR]o.BB+.!>")
  Fatal error: exception Failure("TBD")
  TIMEOUT
