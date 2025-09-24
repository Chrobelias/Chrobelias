regex-005-unsat-multiply-translate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-multiply-translate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "'\x0b'pm;'\x0c'uKdc4EI#RDDD%/C.'\t'z*.CnlhT"3|D=Rylg' '%Yx|n=f8u4k;dDT_@_wD")
  Fatal error: exception Failure("TBD")
  TIMEOUT
