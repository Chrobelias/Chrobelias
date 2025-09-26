regex-016-multiply-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-multiply-fuzz-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "So2!J$Qb3'\\x0c'a}NIq}G'\\x0b'tA'y7_27=auc1_0eKv=m.iiG#,LC+ed&\\\\+S2'\\n'AF%^0Df]vg;'\\x0c')dj0'\\r'\\\\!#86""z4j,{?/:S7)QU'\\n'k~~50'\\t'3")
  Fatal error: exception Failure("TBD")
  TIMEOUT
