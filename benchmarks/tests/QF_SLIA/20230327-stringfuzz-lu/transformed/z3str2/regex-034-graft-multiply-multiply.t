regex-034-graft-multiply-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-034-graft-multiply-multiply.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (m, n)) as string")
  TIMEOUT
