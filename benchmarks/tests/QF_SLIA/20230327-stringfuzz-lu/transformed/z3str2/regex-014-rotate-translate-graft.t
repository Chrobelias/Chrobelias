regex-014-rotate-translate-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-014-rotate-translate-graft.smt2  --no-simpl-alpha  || echo TIMEOUT
  unsat
