str-pred-small-rw_586
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-pred-small-rw/str-pred-small-rw_586.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.suffixof (str.substr x 0 1) y) as string")
  TIMEOUT
