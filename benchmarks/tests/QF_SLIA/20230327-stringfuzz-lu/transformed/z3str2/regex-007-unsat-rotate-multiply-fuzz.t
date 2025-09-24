regex-007-unsat-rotate-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-007-unsat-rotate-multiply-fuzz.smt2  || echo TIMEOUT
  Fatal error: exception String_inside
  TIMEOUT
