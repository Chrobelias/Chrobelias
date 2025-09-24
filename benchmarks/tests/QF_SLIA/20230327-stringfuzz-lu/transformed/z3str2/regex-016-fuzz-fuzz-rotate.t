regex-016-fuzz-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-fuzz-rotate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "a=1Y'\\t'T4'\\t'l*T>v7sDrZrX_AVn,Z`%BwTr9H'\\r'E-7v@9QCi'\\r'_C""Ko\\\\K'\\n'W^fSa;T'\\x0b'h#`W72KR'\\r'C/B{4-J6+\\\\_5.I~@L'28_$GEJzX|i.Cr(q@?!~{tLx.AURP"":&YS%8'PIgEA%>U~zSXC'\\t'-#=j;(")
  Fatal error: exception Failure("TBD")
  TIMEOUT
