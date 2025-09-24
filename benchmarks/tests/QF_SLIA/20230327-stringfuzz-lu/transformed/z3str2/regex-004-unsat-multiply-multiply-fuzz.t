regex-004-unsat-multiply-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-004-unsat-multiply-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "$5Bqa~xV8`Kllbc6ah2z<4Y5NX{'\r'x5R1]5_wJ%DuEun1xiDZDh#[1&diSfk,5Sr{]g'\t'1FVlEcddjj-3u[WKBELJ'\x0b'qaHu=Gn^'eee")
  Fatal error: exception Failure("TBD")
  TIMEOUT
