regex-pair-00006-19
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/generated/regexpair/regex-pair-00006-19.smt2  --no-simpl-alpha  || echo TIMEOUT
  unsat
