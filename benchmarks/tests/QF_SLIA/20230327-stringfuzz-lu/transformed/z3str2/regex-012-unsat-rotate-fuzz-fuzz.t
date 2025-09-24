regex-012-unsat-rotate-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-012-unsat-rotate-fuzz-fuzz.smt2  || echo TIMEOUT
  Fatal error: exception String_inside
  TIMEOUT
