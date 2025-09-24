regex-050-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-050-fuzz.smt2  || echo TIMEOUT
  Fatal error: exception Failure("Expression (str.suffixof \"1\" x) can't be handled")
  TIMEOUT
