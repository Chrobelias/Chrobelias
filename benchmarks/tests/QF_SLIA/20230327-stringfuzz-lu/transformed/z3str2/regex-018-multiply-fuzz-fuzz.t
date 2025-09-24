regex-018-multiply-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-018-multiply-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "YgF!gx'\n'qL!:'wI~Bx+H#o9P=s]cwuW9Z:r;G'\t'j' '5&Yr'\t'tb>udNJ(c:'\x0c'iXEt#(W|0]Qn*k9E/G|:$9/f$IN$'\r'^fk.'\n'>~7|#MS='\n'9=H$n@-^Dv9t3KGV`i{X1C?T_jDsg)7]UF/-Av>ci*PdK'\n'KAhUv:'\x0b''\r'uWA6o'i4BG%qM!Ydy`7mWxC]v=WV+I?jJ]uEzX"dJ9/sz9' 'kTQ'\x0c'e>wi*yZK$,jp'\x0b'Kc4?XjMf{+TChLc'\n''\x0c'615j+wH:'\x0c'jn!Dwn;lz),Ikqg}mgNo")
  Fatal error: exception Failure("TBD")
  TIMEOUT
