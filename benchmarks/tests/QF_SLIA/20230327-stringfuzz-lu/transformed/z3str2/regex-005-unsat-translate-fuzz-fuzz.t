regex-005-unsat-translate-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-005-unsat-translate-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 226 (= x "uvA#)#V*'eh'\r''\n'b'\r''\r'1q},>>NMA(Kbe!'\x0c'(Pf&BM}l5PjKxvV'\n'ZjUa>'\x0c'37)GYrH?AY0q*f'-'N8`{..Y;\\~'\t'(5p4_)%!*'.V9^yL5>|rDB5)M:a[I3'\n'p(")
  Fatal error: exception Failure("TBD")
  TIMEOUT
