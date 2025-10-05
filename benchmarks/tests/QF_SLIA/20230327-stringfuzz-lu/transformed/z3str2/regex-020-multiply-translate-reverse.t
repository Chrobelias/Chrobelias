regex-020-multiply-translate-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-020-multiply-translate-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  unsat
