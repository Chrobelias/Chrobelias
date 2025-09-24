regex-pair-00026-8
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/generated/regexpair/regex-pair-00026-8.smt2  --no-simpl-alpha  || echo TIMEOUT
  unsat
