norn-benchmark-156
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/StringReplace/norn-benchmark-156.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (var_5, \"z\", var_6, var_7)) as string")
  TIMEOUT
