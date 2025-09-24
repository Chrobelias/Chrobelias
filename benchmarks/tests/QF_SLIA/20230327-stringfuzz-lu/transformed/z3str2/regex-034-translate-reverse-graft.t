regex-034-translate-reverse-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-034-translate-reverse-graft.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (n, m)) as string")
  TIMEOUT
