regex-005-unsat-multiply-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-multiply-fuzz-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "{\\\\P.'\\n'CKr]{GYm8nP{a$g$?Qj!&p5r6^D*a'\\r'L'\\t's}/9aap-)F31+xc#{!I.FWa8J-MZFU`kA")
  Fatal error: exception Failure("TBD")
  TIMEOUT
