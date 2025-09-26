regex-020-fuzz-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-020-fuzz-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "KLyfaCodU*[<d`u:P2}ArU6U'y>/@'\r'x\\BOpU99s]W1^p'\x0c'x\\JDv0aS9)Ywn6>|sn'\r'WI'\x0c'UU')QI")
  Fatal error: exception Failure("TBD")
  TIMEOUT
