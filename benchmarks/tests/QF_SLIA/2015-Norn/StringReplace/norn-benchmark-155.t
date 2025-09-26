norn-benchmark-155
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/StringReplace/norn-benchmark-155.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (var_4, \"z\", var_5, var_6)) as string")
  TIMEOUT
