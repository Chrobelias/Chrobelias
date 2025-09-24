regex-050-graft-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-050-graft-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception Failure("Expression (str.suffixof \";\" x) can't be handled")
  TIMEOUT
