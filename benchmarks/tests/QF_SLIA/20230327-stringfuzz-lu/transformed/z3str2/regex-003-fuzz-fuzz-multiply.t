regex-003-fuzz-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "cc,,''\\\\tt''<<::EEQQ==nn88DD..ss--]]hh,,88$$!!PPCCZZQQXXrrLLQQnnooii}}$$HHII,,EE``ttjj{{<<..mm,,zzZZ''$$bbUU''\\\\tt''AA\\\\\\\\??ccII;;@@??PP88CC__qqXX,,~~ss__nnKK''\\\\xx00bb''VVEEOOPP||~~55kk''\\\\tt''SSvv99mmpp??XXff))xx//""""cc''\\\\nn''66gg\\\\\\\\aaHHKK88GGWWaa44YY>>::@@6600##99LLZZ??[[//AAvvMMuuyy,,kk22HH''\\\\tt''ff55DD88==''\\\\tt''33ss")
  Fatal error: exception Failure("TBD")
  TIMEOUT
