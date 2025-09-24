regex-015-graft-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-015-graft-multiply-fuzz.smt2  || echo TIMEOUT
  unsat
