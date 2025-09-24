regex-050-graft-fuzz-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-050-graft-fuzz-graft.smt2  || echo TIMEOUT
  Fatal error: exception Failure("Expression (str.contains \";\" x) can't be handled")
  TIMEOUT
