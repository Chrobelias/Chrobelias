regex-003-fuzz-translate-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-translate-translate.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "M9b}.q0' '}TH<l/'\x0b'n/a/2g}y/'\x0b'-0B/d-1kBu('\n'6{mV/'\x0b'}.q0=}/}.q0' '}<DD;,Q")
  Fatal error: exception Failure("TBD")
  TIMEOUT
