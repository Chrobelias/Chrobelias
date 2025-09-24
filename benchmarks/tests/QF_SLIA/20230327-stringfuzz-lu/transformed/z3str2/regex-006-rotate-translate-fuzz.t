regex-006-rotate-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-rotate-translate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "fz[TD0zvnL/5V@2XH!|M4'\n'DU"qO),W4kcu.X`{b^^' '"ow<H:i^'|r,}AA%l?eF|u6ix,'\n'xhs\\$c'1SP")
  Fatal error: exception Failure("TBD")
  TIMEOUT
