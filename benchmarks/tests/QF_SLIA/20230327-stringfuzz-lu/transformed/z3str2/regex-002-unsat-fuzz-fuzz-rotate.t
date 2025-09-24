regex-002-unsat-fuzz-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-fuzz-fuzz-rotate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "nE0BnYkdRMVn[~Lsh'\\x0b'[=T/p~k$FlZ~#Bh_wJH)i""M^U?bk'' ''QH6lb[odxqxy[!\\\\D'\\r'I|'\\r'pnI}%ZahA~4U""R'' ''M>n!:Q?=IDj'!Ha#YoGlD|9p4d,'u{VCT`ps_/:IkK+(J[LD.^G$+dnSAU{I'\\x0b'O[qK\\\\~43")
  Fatal error: exception Failure("TBD")
  TIMEOUT
