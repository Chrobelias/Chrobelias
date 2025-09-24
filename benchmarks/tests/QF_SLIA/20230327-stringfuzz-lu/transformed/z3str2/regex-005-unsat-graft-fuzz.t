regex-005-unsat-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-graft-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "fV*Vg~z6<zzwY'\x0c'Q4atd'\n'4]~'\x0b'\\[Hi*S[xSq")
  Fatal error: exception Failure("TBD")
  TIMEOUT
