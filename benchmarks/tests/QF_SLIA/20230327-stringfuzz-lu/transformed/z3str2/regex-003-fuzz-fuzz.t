regex-003-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "DiF5}{''\x0b'G.>.cu:yZT#p69b@FisEA4dR!_SX.Qa}3d&'\x0b'8mpwDe$w".OH|'JNC|%#^m,)W'\x0b'*r'Zk:Ai:+r4E'{'\x0b'#W@L<'i]i{/0'VaiPqfxIm'`bM;@KEzozq_'\n';w"+d^VjI8._^m'\r'O=CB&@<U6jJNc72YlD3bohT#'\n''\n'#`:+wRXZ*;59LRwDu`KDG<W-^<q[tJ;@' 'bE?Gw'\r'TI*YJ[ZZ0q&v&nhIrS1Ul'\x0b'7?l@As9"+ire*g9[hnA~}]5cg8'\r'37d1EMe{"O:3zS;~3M=M<(!:.`'\r'3\\zLV?'L'\x0b'oDs[nbC;,W' ',*$>?EJN+{%Wz*Dzgq<#"CYoQpnUQ`#t)=6n+0lkzK5UbTmlddVgr-=z!~8)CohCnN?U*kzy[w!?K$ly9[)[Nz-")
  Fatal error: exception Failure("TBD")
  TIMEOUT
