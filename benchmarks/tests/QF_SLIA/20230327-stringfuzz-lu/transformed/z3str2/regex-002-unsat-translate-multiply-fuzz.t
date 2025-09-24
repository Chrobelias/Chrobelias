regex-002-unsat-translate-multiply-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-002-unsat-translate-multiply-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x "+c4N}vLcsIqY'\n'6`==q/bj4G#%6eX5@`[s={k4"FZ0'uI'\r'wgmWxW$R1Oq=IT}&CptBCww'\t'{w")
  Fatal error: exception Failure("TBD")
  TIMEOUT
