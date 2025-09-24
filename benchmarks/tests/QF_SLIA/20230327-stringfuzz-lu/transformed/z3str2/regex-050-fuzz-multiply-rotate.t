regex-050-fuzz-multiply-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-050-fuzz-multiply-rotate.smt2  || echo TIMEOUT
  Fatal error: exception Failure("Expression (str.prefixof \"11\" x) can't be handled")
  TIMEOUT
