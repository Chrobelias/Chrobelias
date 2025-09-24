str-pred-small-rw_431
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-pred-small-rw/str-pred-small-rw_431.smt2  || echo TIMEOUT
  Fatal error: exception Failure("unable to handle (str.suffixof \"B\" (str.from_int z)) as string")
  TIMEOUT
