norn-benchmark-10
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/2015-Norn/ab/norn-benchmark-10.smt2  --no-simpl-alpha  || echo TIMEOUT
  unsat
