norn-benchmark-1200
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/HammingDistance/norn-benchmark-1200.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (\"b\", var_4)) as string")
  TIMEOUT
