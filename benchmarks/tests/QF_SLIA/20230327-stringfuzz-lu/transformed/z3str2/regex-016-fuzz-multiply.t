regex-016-fuzz-multiply
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-016-fuzz-multiply.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "ttbbcckkRR||""""zzuu^^aacc7755ttbbFF__!!''' '' ''',,1111//wwmmBB")
  Fatal error: exception Failure("TBD")
  TIMEOUT
