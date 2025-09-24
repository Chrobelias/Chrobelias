regex-016-translate-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-translate-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "NM@S[mLuMEKFcU' 'F#{NFdGU'\x0c'xPe@uLB+\\'hp/G!dR${t1n@TY8;j<LR&A;Bz'\t')\\gWW9j^j>5`Z;2F'\x0b'4aNN(#[C*1^=E")
  Fatal error: exception Failure("TBD")
  TIMEOUT
