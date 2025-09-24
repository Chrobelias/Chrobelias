regex-003-translate-fuzz-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-translate-fuzz-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "----'\x0c'#0?y?#-{#]iUk1=gx1>`--3Rf'R$E#-G#BBZ' '<$' 'C#t9+pBBY")
  Fatal error: exception Failure("TBD")
  TIMEOUT
