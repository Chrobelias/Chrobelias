regex-deep-00002-0
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/generated/regexdeep/regex-deep-00002-0.smt2  || echo TIMEOUT
  Fatal error: exception String_inside
  TIMEOUT
