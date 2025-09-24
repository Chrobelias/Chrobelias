regex-026-graft-reverse-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-026-graft-reverse-reverse.smt2  || echo TIMEOUT
  Fatal error: exception String_inside
  TIMEOUT
