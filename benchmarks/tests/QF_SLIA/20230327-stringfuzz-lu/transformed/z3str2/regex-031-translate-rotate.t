regex-031-translate-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-031-translate-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (x, y)) as string")
  TIMEOUT
