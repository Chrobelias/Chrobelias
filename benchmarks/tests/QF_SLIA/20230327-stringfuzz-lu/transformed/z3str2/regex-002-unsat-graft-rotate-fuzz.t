regex-002-unsat-graft-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-graft-rotate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "[r_(TwL[,"aa1W-\\_q'\x0b''_<))~"Ge)a")
  Fatal error: exception Failure("TBD")
  TIMEOUT
