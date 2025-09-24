regex-016-fuzz-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-translate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "' 'n0:(V%|'\x0c'WuY)J'\x0c'.Y{<I>Q'\r'FV[_FD'\t'SDBBf76k'\x0b'aDN?CH[i;'\r'lp'\n'l|*gM7`p(Py<#5}'Sz'\x0c'Vm[%^MF*BCBxQ^'\r'13'\r'b?xm0q$QM0*wRV|!OK;S&7y[di5%y,' '=U7Wz@p'\x0b'pWnOUMYR=ig|'\n''\n'uh3!z7sXj|hi=h(ZEF,,`bn#J^w@Q3Hm^,rI>N11@'\r'tt8]CZ:omtQ46'\x0b'4I*~Tk3SRXQH]e+l@+vA%;*k!sq1u-0Iw0*i41'\n'#'")
  Fatal error: exception Failure("TBD")
  TIMEOUT
