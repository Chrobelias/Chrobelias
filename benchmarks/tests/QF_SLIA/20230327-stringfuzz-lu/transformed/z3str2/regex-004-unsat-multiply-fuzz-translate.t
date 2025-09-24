regex-004-unsat-multiply-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-multiply-fuzz-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "L7'\x0c'4_%QE'\r'gb%dSI:HP{'\r'r(L0#rgZk/]]]]'\n'.b' 'nr:UUXJp[&%r(srF~OIo_e;6'\x0c'f%%4r.1n5")
  Fatal error: exception Failure("TBD")
  TIMEOUT
