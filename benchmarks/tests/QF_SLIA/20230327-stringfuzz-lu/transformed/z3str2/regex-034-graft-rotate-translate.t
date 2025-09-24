regex-034-graft-rotate-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-034-graft-rotate-translate.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (m, n)) as string")
  TIMEOUT
