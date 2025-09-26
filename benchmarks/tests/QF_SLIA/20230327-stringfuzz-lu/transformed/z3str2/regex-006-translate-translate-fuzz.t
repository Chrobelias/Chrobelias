regex-006-translate-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-translate-translate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "!FZcawr' 'W}kl[LTcl"g$De[J9lh(R(5Z1^>B'\x0b'jYv;%;p<RY;'\r'_+P*KeGBL|5v\\sO$x'\n'+Fi]c&or''\x0c'v'\t'VA2hpA=Hz6xri('x0O|_Je'>V~9prG^"7qLy&MBx:z'\t'.1#1Q\\z/*C],*A;' ''\x0b';A1\\''\\\\`d?2uJ[2o\\J~%?:[~&=NF.IDGaktUaX"[&9RY%fe/Qb!'\x0b'l:m$9EX&'\x0b'dTSM,TyIk' 'LXB&k'\r'tap2;#G\\/jUd'\n'P7A'\t'-h\\FU,}2W@f92\\t")
  Fatal error: exception Failure("TBD")
  TIMEOUT
