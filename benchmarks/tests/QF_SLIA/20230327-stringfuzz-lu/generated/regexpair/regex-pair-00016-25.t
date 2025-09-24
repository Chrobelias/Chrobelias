regex-pair-00016-25
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/generated/regexpair/regex-pair-00016-25.smt2  --no-simpl-alpha  || echo TIMEOUT
  unsat
