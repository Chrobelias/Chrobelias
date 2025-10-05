regex-035-graft-reverse-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-035-graft-reverse-graft.smt2  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception File "lib/SimplII.ml", line 181, characters 11-17: Assertion failed
  TIMEOUT
