regex-005-unsat-translate-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-translate-fuzz-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "VV6.'b0x\\'<]2}D-'c0x\\')YJ.auV")
  Fatal error: exception Failure("TBD")
  TIMEOUT
