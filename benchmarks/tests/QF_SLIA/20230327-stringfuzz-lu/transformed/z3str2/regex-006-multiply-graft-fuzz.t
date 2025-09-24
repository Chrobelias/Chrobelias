regex-006-multiply-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-006-multiply-graft-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "NHsVIab&' 'O@v#M4$%K'\x0b'zTkc@q3Q)3I0O@abcc")
  Fatal error: exception Failure("TBD")
  TIMEOUT
