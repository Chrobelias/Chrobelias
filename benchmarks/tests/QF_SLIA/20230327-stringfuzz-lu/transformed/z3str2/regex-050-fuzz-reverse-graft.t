regex-050-fuzz-reverse-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-050-fuzz-reverse-graft.smt2  || echo TIMEOUT
  Fatal error: exception Failure("Expression (str.prefixof \"1\" x) can't be handled")
  TIMEOUT
