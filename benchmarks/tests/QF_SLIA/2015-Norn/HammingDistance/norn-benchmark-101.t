norn-benchmark-101
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/HammingDistance/norn-benchmark-101.smt2  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle re.none as regex")
  TIMEOUT
