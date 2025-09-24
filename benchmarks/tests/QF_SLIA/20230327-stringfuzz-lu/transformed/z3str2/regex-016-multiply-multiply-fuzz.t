regex-016-multiply-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-multiply-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "{h$+NakB'NkR~b|ZY+h5rWE''\x0b'("ST`E2A|>J*Vy%YpsM_,ltk'\x0c'j$'\t'YY|yTupxQVh5g)&5O(bwY:qdxhQ"fm]E2W'\t'W-$l6czk[wHc~YS5]OKgr5BA$QZC$\\34GX~<-oY90Db(XF=:^4;,t>z4Ak!9.XY_WQu'\x0b'>LG>usZ'\x0b'IWgeABv']M0L.R}Q3-*Ye3{VxSFH'\t'qd@U.*:"+:Jd' 'x^O' '-)W&$(' '4hfmZE7s^6/_.@EcNl}*G'\x0c'f7x3LU$;Lze+b"^[_JUA='\r'H"a@C})$`cbZ)D.?^(t"'\n''\t'/a9Hb9GUI[1n'\t'EExYEJt'\n'$' ',^y{VT9F'\x0c'ed'\t'(w('\x0c'PqI"J'\n'+V29o'\x0b'lcXQ@kU' 'G[.`H8t1'\r'sWHm'J~[cDL6h_2c+cGf.>W6Jddd112-#ltb|<T}<Lirm' '3")
  Fatal error: exception Failure("TBD")
  TIMEOUT
