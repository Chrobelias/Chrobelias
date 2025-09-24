norn-benchmark-153
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/StringReplace/norn-benchmark-153.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (var_7, \"z\", var_8, var_9)) as string")
  TIMEOUT
