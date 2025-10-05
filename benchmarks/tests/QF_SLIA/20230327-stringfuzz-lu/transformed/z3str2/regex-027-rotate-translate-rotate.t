regex-027-rotate-translate-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-027-rotate-translate-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  unsat
