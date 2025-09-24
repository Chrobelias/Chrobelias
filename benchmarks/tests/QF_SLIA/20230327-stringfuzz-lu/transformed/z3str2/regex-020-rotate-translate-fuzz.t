regex-020-rotate-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-020-rotate-translate-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "'A2#=?'\t'o_[-un0Hs{nRf)d+{79np3bfIG0}")
  Fatal error: exception Failure("TBD")
  TIMEOUT
