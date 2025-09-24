regex-003-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "dee~+,1O6e+kXr7jR;H*bb*P@VcVe1!"8?uEUs'\n'[I3y:JVA9LS>\\Q0c-cg)oM+9@Q,<e")
  Fatal error: exception Failure("TBD")
  TIMEOUT
