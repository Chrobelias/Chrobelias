norn-benchmark-118
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/StringReplace/norn-benchmark-118.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (var_9, \"z\", \"b\", var_10)) as string")
  TIMEOUT
