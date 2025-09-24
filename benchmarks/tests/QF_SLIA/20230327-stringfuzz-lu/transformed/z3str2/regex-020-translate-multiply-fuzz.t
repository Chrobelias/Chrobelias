regex-020-translate-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-020-translate-multiply-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "''' 'A"(:E`I`m1sJ7UwaW'\t'Naz92_ExL,n=w4e$ti\\\\t0H|m_~Wz!1'\x0c's&#torFuj'\n'''\\\\7|7JU)&6V<''zz")
  Fatal error: exception Failure("TBD")
  TIMEOUT
