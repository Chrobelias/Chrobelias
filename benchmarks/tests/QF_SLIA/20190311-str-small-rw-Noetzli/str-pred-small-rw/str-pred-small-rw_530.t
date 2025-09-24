str-pred-small-rw_530
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-pred-small-rw/str-pred-small-rw_530.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (bool.eq \"\" (str.substr \"A\" 0 z)) as string")
  TIMEOUT
