regex-018-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "rXi7E0SW[{W2?bJuqmXJL^ffqv34KY<et+3\\t'\t'5T-DdV+Sj0OY")
  Fatal error: exception Failure("TBD")
  TIMEOUT
