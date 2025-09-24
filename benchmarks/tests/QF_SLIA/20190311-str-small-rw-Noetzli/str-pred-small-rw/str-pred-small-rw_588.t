str-pred-small-rw_588
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-pred-small-rw/str-pred-small-rw_588.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.prefixof (str.substr x 0 z) x) as string")
  TIMEOUT
