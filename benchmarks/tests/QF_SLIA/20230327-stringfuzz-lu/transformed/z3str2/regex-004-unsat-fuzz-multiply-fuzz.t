regex-004-unsat-fuzz-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-fuzz-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "`5/gY(&ZHAb'_VZ)d@Fo{D#'\t'\\j{u,pH?u8_efcDy/="S|Ddd")
  Fatal error: exception Failure("TBD")
  TIMEOUT
