regex-002-unsat-fuzz-graft-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-fuzz-graft-fuzz.smt2  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "r*&:/JTs{$.'iq!PLi<{@&W"M1['\t'FLC2ePp;Dcd'\x0b',kBtpp1m>hh\\\\cr'\x0c'+`X2\\m\\|og(S(egoIF}Al28}[ZFKUP2''{CkR,o_S'%ueq)X@"u_nO9f(&u9oA[2iL9DQFUq?'\n'2yda")
  Fatal error: exception Failure("TBD")
  TIMEOUT
