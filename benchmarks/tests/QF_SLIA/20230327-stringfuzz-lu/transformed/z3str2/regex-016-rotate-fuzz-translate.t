regex-016-rotate-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-rotate-fuzz-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "0mKNz%Tn_WWY"x1|>YkWW~REKpL'\t'x1KlWW31h5kSc=KOK")
  Fatal error: exception Failure("TBD")
  TIMEOUT
