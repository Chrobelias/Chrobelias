regex-005-unsat-fuzz-multiply-translate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-fuzz-multiply-translate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "NNNNGGJJ[[zzxxNN'\x0b''\x0b''\x0c''\x0c''\x0b''\x0b'--UUUUVV--eeggii--%%eeZZ99$$ddNN")
  Fatal error: exception Failure("TBD")
  TIMEOUT
