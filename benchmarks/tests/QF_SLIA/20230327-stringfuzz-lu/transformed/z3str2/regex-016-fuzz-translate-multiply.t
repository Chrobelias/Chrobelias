regex-016-fuzz-translate-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-translate-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "!!%%EEppSS__FFFF$$``''' '' '''ggEE7755!!%%yy++zzRRrrRRNN1111ss@@DD''\\\\nn''")
  Fatal error: exception Failure("TBD")
  TIMEOUT
