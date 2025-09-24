regex-050-rotate-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-050-rotate-graft-fuzz.smt2  || echo TIMEOUT
  Fatal error: exception Failure("Expression (str.prefixof \"j\" x) can't be handled")
  TIMEOUT
