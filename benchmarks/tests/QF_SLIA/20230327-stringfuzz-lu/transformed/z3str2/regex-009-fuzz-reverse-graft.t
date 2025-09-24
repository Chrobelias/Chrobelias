regex-009-fuzz-reverse-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-009-fuzz-reverse-graft.smt2  || echo TIMEOUT
  unsat
