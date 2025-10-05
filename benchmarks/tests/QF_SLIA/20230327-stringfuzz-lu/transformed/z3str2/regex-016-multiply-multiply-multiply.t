regex-016-multiply-multiply-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-multiply-multiply-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  unsat
