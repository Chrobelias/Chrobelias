regex-006-fuzz-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-fuzz-multiply-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x ",&2,MX'\n'\\ktT4et/'\r'<gn&'#}<CDL0H{ZLypQ"2Y=_<`}N@?),3nLdAtx~mA$Fw'\x0b'2G/)&;k<lu"?X9")
  Fatal error: exception Failure("TBD")
  TIMEOUT
