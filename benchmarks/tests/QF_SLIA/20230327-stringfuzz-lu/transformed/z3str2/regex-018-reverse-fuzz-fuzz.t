regex-018-reverse-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-reverse-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "R]8.Hugr1i*(-N' '{R=MXJx' '5;k65,'\x0c''\t'0?K,pV#82DDcoDa!s{S'0Elf>2.$'\x0c'\\\\\\'f'#M9F#fQY6x")
  Fatal error: exception Failure("TBD")
  TIMEOUT
