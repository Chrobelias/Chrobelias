regex-016-multiply-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-multiply-translate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "**dR2K>`J'\t'Cp<u-%dcN(=&DU9~%iH%,*:@0O$+8UD]WM' 'DSQ{%=};PV/{o}Z|OdB@"sKW' ',msx~!<wDk<LhrO'\t';\\'\n'chJM,*],'])gy'\n'iC6I@^3")
  Fatal error: exception Failure("TBD")
  TIMEOUT
