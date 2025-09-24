norn-benchmark-55
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/StringReplace/norn-benchmark-55.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (\"z\", var_4)) as string")
  TIMEOUT
