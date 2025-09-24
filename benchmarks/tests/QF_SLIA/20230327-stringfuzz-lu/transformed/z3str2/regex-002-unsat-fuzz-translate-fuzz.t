regex-002-unsat-fuzz-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-fuzz-translate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "<)aUA"h'\r'j)Pylf}'\x0c'd"|IPWubcJG9={Z'\t''\r'av{tRfj:&-dTQ'\x0b'7' '0fq,Tx#E,AolT('gYN+B'\x0c'+h[e`iwDLJ>gD.4")
  Fatal error: exception Failure("TBD")
  TIMEOUT
