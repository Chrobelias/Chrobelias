regex-003-fuzz-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-fuzz-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "]Zy%ky:>ANU#8f(E/'\x0b'iZ8"'Hh'\t'N)l' 'N#n+<",vZAwko_:(qZt'\t'y"T'\r'y%kyI%%S]vp-SH8hDO)ZLED#sy%b0TyCAWHQL5uy%kyV?9q|S)=jbc!!]y%#y6e%%@,s8~F@4Kr>-60'\x0c'9' ''\t'SJcI?XMYZu2,y%ky=5f8Uy%ky3E")
  Fatal error: exception Failure("TBD")
  TIMEOUT
