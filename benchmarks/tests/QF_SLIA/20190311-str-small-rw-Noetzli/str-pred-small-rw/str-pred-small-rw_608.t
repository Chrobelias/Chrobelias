str-pred-small-rw_608
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-pred-small-rw/str-pred-small-rw_608.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.prefixof (str.substr x z 0) y) as string")
  TIMEOUT
