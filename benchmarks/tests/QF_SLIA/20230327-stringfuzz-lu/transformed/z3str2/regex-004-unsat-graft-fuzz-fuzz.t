regex-004-unsat-graft-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-graft-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "B3a0d[VE2I7:8d2oKbdW[=N{yP3,bR5\\'y!y.gmtV'\x0c']5'\x0c''\x0b'|u'\n'r' 's4O^|'\t'W)'\t'xe@ll@P/'\n'0lzEKD};' 'H>lu>,")
  Fatal error: exception Failure("TBD")
  TIMEOUT
