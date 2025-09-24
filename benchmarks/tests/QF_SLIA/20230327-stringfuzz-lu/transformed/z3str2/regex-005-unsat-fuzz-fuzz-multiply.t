regex-005-unsat-fuzz-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-fuzz-fuzz-multiply.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "aaaa$$1166@@ggHHqq;;EE''\\\\nn''MM@@RR**``JJ<<''\\\\rr''}}OOkkQQ''\\\\xx00cc''AAjj""""==FFLLMM??FFmmjjaaPPxxLLZZ''\\\\xx00bb''..uu##}}ss''\\\\tt''FFKKLLee==QQIIIILL<<\\\\\\\\--||nn''ww88''\\\\nn''33ZZ$$??pp<<5555^^ww**--5599''\\\\rr''UU88CCQQPP``QQ''\\\\xx00bb''""""IILLJJII''\\\\nn''BB<<KK}}QQ''\\\\tt''WWaaNNQQee99PP,,""""PPii""""PP]]>>__ttcc((OO''\\\\xx00cc''BB-->>xx88;;~~..&&ffbb")
  Fatal error: exception Failure("TBD")
  TIMEOUT
