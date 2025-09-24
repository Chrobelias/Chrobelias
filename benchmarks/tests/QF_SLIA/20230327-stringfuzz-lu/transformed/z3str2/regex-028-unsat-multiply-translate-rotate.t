regex-028-unsat-multiply-translate-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-028-unsat-multiply-translate-rotate.smt2  || echo TIMEOUT
  Fatal error: exception String_inside
  TIMEOUT
