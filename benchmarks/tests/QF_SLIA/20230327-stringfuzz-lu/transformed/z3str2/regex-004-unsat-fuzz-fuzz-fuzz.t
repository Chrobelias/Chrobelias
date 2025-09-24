regex-004-unsat-fuzz-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-fuzz-fuzz-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "a'\x0c'*7Btp@X?w'\r'pX'\n'MD%'\t'UPQ{h'\\=D--t:%OfAIA-%l(<"j'\n'qq7b*$9I7Iv*3+/m-;"@@Fc6LvjL*TLTMs3^K$)_9qLSekmmUj'\x0c'' 'Y.Tyrm}"io~H_8\\KJ4a2h%LX"mO`q-cf^Gb)|1Pi|)D(sA)]O~)Dm'\x0b'lD\\jD'>'\x0c'd%:['\x0b'?'\t'\\>7]1JJn]&yV'\t'!b\\[W")
  Fatal error: exception Failure("TBD")
  TIMEOUT
