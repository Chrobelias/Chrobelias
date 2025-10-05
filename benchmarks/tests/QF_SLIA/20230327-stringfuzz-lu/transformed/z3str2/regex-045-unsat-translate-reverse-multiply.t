regex-045-unsat-translate-reverse-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-045-unsat-translate-reverse-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  unsat
