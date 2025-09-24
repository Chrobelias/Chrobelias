regex-003-multiply-fuzz-graft
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-multiply-fuzz-graft.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "cd'\\x0b'LHK1mabcdcz%4""C_FtPO='\\t''\\x0b'[lrCSIEME~'\\x0c'Y1$'\\t'}~3d'\\n'=3wZn[yB'\\n'0_6NZRA")
  Fatal error: exception Failure("TBD")
  TIMEOUT
