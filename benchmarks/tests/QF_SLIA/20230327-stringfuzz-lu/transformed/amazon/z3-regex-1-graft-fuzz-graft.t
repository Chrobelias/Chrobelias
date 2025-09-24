z3-regex-1-graft-fuzz-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/amazon/z3-regex-1-graft-fuzz-graft.smt2  --no-simpl-alpha  || echo TIMEOUT
  unsat
