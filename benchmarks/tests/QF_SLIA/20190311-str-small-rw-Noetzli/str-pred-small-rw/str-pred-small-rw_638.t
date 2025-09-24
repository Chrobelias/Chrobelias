str-pred-small-rw_638
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-pred-small-rw/str-pred-small-rw_638.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.contains (str.substr \"\" 0 z) x) as string")
  TIMEOUT
