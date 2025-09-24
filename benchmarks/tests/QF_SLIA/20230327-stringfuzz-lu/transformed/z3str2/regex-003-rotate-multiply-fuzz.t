regex-003-rotate-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-rotate-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "ccdde`rP'\x0b'PE&EK'\x0c'[$X(h?:^,?wYaahoq69F\\1B1Rt0z#g8zy'\t'{m#^OUk1mJdf'\n'jetb&rL54>ee")
  Fatal error: exception Failure("TBD")
  TIMEOUT
