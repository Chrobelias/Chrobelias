regex-016-fuzz-translate-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-translate-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "'n\\'D@s11NRrRz+y%!57Eg'' ''`$FF_SpE%!")
  Fatal error: exception Failure("TBD")
  TIMEOUT
