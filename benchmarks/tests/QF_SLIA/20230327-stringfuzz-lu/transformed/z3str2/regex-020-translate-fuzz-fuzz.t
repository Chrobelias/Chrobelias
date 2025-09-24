regex-020-translate-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-020-translate-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "fd1(' ''\x0b'>H"<vHL2Z'\x0b'Q%'\\I/'\n'"T(>O>zg4c2L2!*>#Ym@7AfOQ>'\r'hv(fjB?/AU,0Bq3S|^aXKL^k&Hg$P")
  Fatal error: exception Failure("TBD")
  TIMEOUT
