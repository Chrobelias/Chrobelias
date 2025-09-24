regex-050-fuzz-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-050-fuzz-fuzz-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception Failure("Expression (str.contains \"1\" x) can't be handled")
  TIMEOUT
