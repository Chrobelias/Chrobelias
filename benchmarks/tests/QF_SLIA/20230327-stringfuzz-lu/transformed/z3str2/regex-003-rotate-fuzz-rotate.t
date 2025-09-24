regex-003-rotate-fuzz-rotate
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-rotate-fuzz-rotate.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "Qf9""<?CNe.=v'\\n'$D*;YBS'' ''e")
  Fatal error: exception Failure("TBD")
  TIMEOUT
