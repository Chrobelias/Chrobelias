regex-002-unsat-multiply-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-multiply-rotate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "(n;' 'Qiaaaaaao+"B/".bMCO'\x0b'vFlafNAQp'\t'v*.Hps-*ItnIs")
  Fatal error: exception Failure("TBD")
  TIMEOUT
