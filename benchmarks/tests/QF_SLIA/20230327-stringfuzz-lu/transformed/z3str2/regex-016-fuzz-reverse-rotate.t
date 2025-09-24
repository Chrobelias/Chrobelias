regex-016-fuzz-reverse-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-reverse-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x ";4non1dbUA.):q(Gd)Cd!$EabVus+o8{a")
  Fatal error: exception Failure("TBD")
  TIMEOUT
