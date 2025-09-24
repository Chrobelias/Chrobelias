str-pred-small-rw_400
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-pred-small-rw/str-pred-small-rw_400.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (bool.eq \"A\" (str.replace \"A\" x \"A\")) as string")
  TIMEOUT
