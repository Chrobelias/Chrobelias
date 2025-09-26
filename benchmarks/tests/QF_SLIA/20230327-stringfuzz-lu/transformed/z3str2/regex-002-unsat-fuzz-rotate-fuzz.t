regex-002-unsat-fuzz-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-fuzz-rotate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "~zJlA]\\' '~7_^j.UuNc*R#_6,eMk9<~$Su'\x0c'_'\x0b'3o'\r'-i9}[q0$Xl4|ZJP' 'N=Ghn"j[`'\n'US'?&qZea^5$|^'\n'^'\t'*`nr,UP7,Y.BgOq9s'\x0b''\n'Z`' 'SpyN\\\\<aYuy'\r'RmSrdn~'Fgm_*`~<v*bHg'\x0b'#'\n'ih?l{'\x0c'9[a.8P<4gQ'\x0b'o"c>u' 'oLabAnM|5WOT-LW8d35}g-uec{7#o`saiRl4")
  Fatal error: exception Failure("TBD")
  TIMEOUT
