regex-003-fuzz-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-fuzz-rotate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "c,'\\t'<:EQ=n8D.s-]h,8$!PCZQXrLQnoi}$HI,E`tj{<.m,zZ'$bU'\\t'A\\\\?cI;@?P8C_qX,~s_nK'\\x0b'VEOP|~5k'\\t'Sv9mp?Xf)x/""c'\\n'6g\\\\aHK8GWa4Y>:@60#9LZ?[/AvMuy,k2H'\\t'f5D8='\\t'3s")
  Fatal error: exception Failure("TBD")
  TIMEOUT
