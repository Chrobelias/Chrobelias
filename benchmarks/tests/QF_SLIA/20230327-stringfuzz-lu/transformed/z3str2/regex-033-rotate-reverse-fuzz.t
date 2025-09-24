regex-033-rotate-reverse-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-033-rotate-reverse-fuzz.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (y, x)) as string")
  TIMEOUT
