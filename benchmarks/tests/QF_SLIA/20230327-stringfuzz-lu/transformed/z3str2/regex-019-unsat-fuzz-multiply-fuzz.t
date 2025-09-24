regex-019-unsat-fuzz-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-019-unsat-fuzz-multiply-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x ":UGv7%/G.^=Gvs'\x0c'..'\t'e8B%>n")
  Fatal error: exception Failure("TBD")
  TIMEOUT
