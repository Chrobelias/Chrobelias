str-pred-small-rw_773
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/QF_SLIA/20190311-str-small-rw-Noetzli/str-pred-small-rw/str-pred-small-rw_773.smt2  || echo TIMEOUT
  Fatal error: exception Failure("expected term, in (bool.eq (str.replace \"A\" \"B\" x) y)")
  TIMEOUT
