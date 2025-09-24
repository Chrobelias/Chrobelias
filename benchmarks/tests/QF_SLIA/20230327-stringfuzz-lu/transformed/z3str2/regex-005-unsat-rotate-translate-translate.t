regex-005-unsat-rotate-translate-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-rotate-translate-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "h"hh"hh"hh"hh"hh"hh"hh"hh"h")
  Fatal error: exception Failure("TBD")
  TIMEOUT
