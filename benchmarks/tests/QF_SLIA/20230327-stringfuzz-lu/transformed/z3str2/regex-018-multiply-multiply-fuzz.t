regex-018-multiply-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-multiply-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "11B{W<fW_M'\t'C~kK6ZWo]f)Z"{)h>|d$'\t''hYD]bofp' 's"-wW,\\a"233{'`f{q'\r'3rxa'\t'@e#AAbhxw{b{00'\r'M")
  Fatal error: exception Failure("TBD")
  TIMEOUT
