norn-benchmark-25
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/HammingDistance/norn-benchmark-25.smt2  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.++ (\"a\", var_5, \"z\", \"a\", var_5)) as string")
  TIMEOUT
