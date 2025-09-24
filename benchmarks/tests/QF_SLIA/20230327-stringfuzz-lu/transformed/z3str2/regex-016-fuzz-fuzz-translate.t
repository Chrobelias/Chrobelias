regex-016-fuzz-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-fuzz-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "|T1^;co;Y4;co;PvYFs7'\n'{>=>$~+e/a=-zdyY>9q;c>;[_7sB9,iE;c>;~iQQkxcck;c/;'\x0b'gX.|uY;c*0];U@-'\x0b'72kR;c>;iSdp4_' '6#cc~5NAtB:;28~bL[' '%$`ENi>IhBZMtpo:*N+)R&QQrC^.z8;&AH[+zF)t%.$i;co;_@TKuI")
  Fatal error: exception Failure("TBD")
  TIMEOUT
