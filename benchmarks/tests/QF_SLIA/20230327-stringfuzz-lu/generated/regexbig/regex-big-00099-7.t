regex-big-00099-7
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/generated/regexbig/regex-big-00099-7.smt2  || echo TIMEOUT
  Fatal error: exception String_inside
  TIMEOUT
