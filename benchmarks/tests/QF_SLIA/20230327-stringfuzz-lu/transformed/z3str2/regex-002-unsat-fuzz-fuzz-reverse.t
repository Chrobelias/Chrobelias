regex-002-unsat-fuzz-fuzz-reverse
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-fuzz-fuzz-reverse.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "34~\\\\Kq[O'b0x\\'I{UASnd+$G^.DL[J(+KkI:/_sp`TCV{u',d4p9|DlGoY#aH!'jDI=?Q:!n>M'' ''R""U4~AhaZ%}Inp'r\\'|I'r\\'D\\\\![yxqxdo[bl6HQ'' ''kb?U^M""i)HJw_hB#~ZlF$k~p/T=['b0x\\'hsL~[nVMRdkYnB0En")
  Fatal error: exception Failure("TBD")
  TIMEOUT
