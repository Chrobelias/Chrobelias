regex-004-unsat-multiply-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-multiply-rotate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "B'\x0b'7/a`o3IR)DHA+>K;_S{TIR#ac'\t'+_"5U]s' '")
  Fatal error: exception Failure("TBD")
  TIMEOUT
