str-pred-small-rw_566
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-pred-small-rw/str-pred-small-rw_566.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.prefixof (str.at x 0) x) as string")
  TIMEOUT
