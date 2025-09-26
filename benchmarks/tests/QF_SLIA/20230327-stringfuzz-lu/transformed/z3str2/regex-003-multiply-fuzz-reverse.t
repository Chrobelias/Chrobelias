regex-003-multiply-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-multiply-fuzz-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "ARZN6_0'n\\'By[nZw3='n\\'d3~}'t\\'$1Y'c0x\\'~EMEISCrl['b0x\\''t\\'=OPtF_C""4%zcdcbam1KHL'b0x\\'dc")
  Fatal error: exception Failure("TBD")
  TIMEOUT
