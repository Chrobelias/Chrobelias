regex-005-unsat-fuzz-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-fuzz-graft-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "aa$CZBZDTpY5ea' ';'\x0b'L.9bz;]E,R;|hh'm_:SkYq@>MY/bW,df7\\'c5:"wv@z[t...qMz'\x0b'9M'\r'A9>aswpCQ8!rJkw:Qyj.-'\r'9+:(@I^Ga")
  Fatal error: exception Failure("TBD")
  TIMEOUT
