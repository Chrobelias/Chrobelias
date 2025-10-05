regex-034-graft-graft-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-034-graft-graft-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  unknown
  ; converting to automaton expression: concatenation makes the formula undecideable
