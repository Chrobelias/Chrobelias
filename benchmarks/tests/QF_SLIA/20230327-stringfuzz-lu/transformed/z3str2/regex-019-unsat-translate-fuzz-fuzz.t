regex-019-unsat-translate-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-019-unsat-translate-fuzz-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "cPa' 'nwwWM['\x0b'bXTqX#C5_b&/o`|EI{YyhB9b!:T03]'\x0c'?GFZ='#67*"M[y1KIWIf'\n'QUN[-gyd2r2<WqKh*l3Y[-' 'xSBYa'\r'2qZw]tC-?OiZ"~d,lgJl'\t'1' '/a'\x0c'/=U-bAmBZW"Pm:W.v'\r'=C3taGD'.h&:]Mn}l'\t'En5*HEexW*>^s^fPx2J\\h.'\x0c'H0W<bcG'\x0c'3'\x0c'"d")
  Fatal error: exception Failure("TBD")
  TIMEOUT
