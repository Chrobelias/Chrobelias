norn-benchmark-92
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/ab/norn-benchmark-92.smt2  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle re.none as regex")
  TIMEOUT
