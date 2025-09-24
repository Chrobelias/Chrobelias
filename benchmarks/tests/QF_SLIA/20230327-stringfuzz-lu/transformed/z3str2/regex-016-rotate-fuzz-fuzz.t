regex-016-rotate-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-rotate-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "0]}@GP-"{rE(}xAQ%#Zcj3u(\\@Bd]5B'\n''\x0c'nin'\n'p'\x0c'!Z1H.N`OU=p:}|'Tq3iU'\n'de\\NRyu|<0r3hk2X+'6JFw=bJQ~N|#QvX'\x0c'^E&a'ZIp]&8M`"A[h'\x0b'd:ifd"y'\r'w%F!@%'\t'+P9ZHey$OxIb'\r'hKLo'\r':W?|Skf(Y,1c"^_cN8%A$YeubTj*0bwe'\x0c',5uc'\x0b'RSQ&7v7fdh'\t'J]#wG$dz-S+me' '\\^rf0HHbKP;k_+.r>/[l}b'Wg4U$tQA8P$ior~Id'\n'Ia!0+4ZQZ!o9P^T^:'\r'#q9P' 'gr<Rtq'\r'&,8tq\\zEQb'\r'/Nfw:xZE}3IyNoGq""u2b=~v2@TTqq::m5IXWperdW;\\xdN#4'\n'Wu~:yWQ(+!"cBR'\t''\t'<$v!:v<76nXX{~R64Nf$3'\x0b'<5P@Gf|'\r'SVc9t'\r'z:xx)'\t';'\r'9oC(\\l!+c'\r'd#abl>@EF[|8r{m{QzNu~' '")
  Fatal error: exception Failure("TBD")
  TIMEOUT
