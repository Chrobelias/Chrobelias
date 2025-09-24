norn-benchmark-128
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/ab/norn-benchmark-128.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (\"a\", var_4, \"b\")) as string")
  TIMEOUT
