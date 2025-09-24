regex-027-multiply-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-027-multiply-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "b,uHVZ+{uCh' 'hI$]FgPc*j&qM'\x0b''\t'j7'\t'[NWgz{sx)^E9n")
  Fatal error: exception Failure("TBD")
  TIMEOUT
