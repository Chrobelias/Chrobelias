regex-019-unsat-multiply-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-019-unsat-multiply-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x ".4^bXXd'\x0b'-['\t'c!'\n'"...w*ZRymmcl=WR3.Z?..IB2M3qg.")
  Fatal error: exception Failure("TBD")
  TIMEOUT
