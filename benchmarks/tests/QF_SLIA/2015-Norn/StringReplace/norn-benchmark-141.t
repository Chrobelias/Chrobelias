norn-benchmark-141
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/StringReplace/norn-benchmark-141.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (var_7, \"z\", \"b\", var_8)) as string")
  TIMEOUT
