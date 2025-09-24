str-pred-small-rw_119
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-pred-small-rw/str-pred-small-rw_119.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.contains x (str.substr \"\" 1 z)) as string")
  TIMEOUT
