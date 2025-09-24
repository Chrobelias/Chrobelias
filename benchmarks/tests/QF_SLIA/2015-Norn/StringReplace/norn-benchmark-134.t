norn-benchmark-134
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/StringReplace/norn-benchmark-134.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (var_5, \"z\", \"b\", var_6)) as string")
  TIMEOUT
