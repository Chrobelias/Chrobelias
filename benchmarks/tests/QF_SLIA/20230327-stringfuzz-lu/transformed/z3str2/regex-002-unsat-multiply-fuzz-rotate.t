regex-002-unsat-multiply-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-multiply-fuzz-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "P_Xy*!rD1aavZ[<{pgXj4Nu'\\n'V|D8,Z`Jj5,aCjnWg+re)h,zb>)Q6CuIiLG'\\r'0aag0b_z)lO0of'\\x0c'Y'\\x0b'o~aaa")
  Fatal error: exception Failure("TBD")
  TIMEOUT
