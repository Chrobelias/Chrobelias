regex-031-multiply-rotate-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-031-multiply-rotate-rotate.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (x, y)) as string")
  TIMEOUT
