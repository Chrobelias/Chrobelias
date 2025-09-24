z3-regex-2-negative-translate-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/amazon/z3-regex-2-negative-translate-fuzz-reverse.smt2  || echo TIMEOUT
  Fatal error: exception String_inside
  TIMEOUT
