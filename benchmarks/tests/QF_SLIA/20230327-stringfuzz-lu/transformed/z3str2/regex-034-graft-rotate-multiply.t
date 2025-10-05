regex-034-graft-rotate-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-034-graft-rotate-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception Failure("unable to create regex dynamically in (str.++ (x, y))")
  TIMEOUT
