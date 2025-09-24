regex-019-unsat-reverse-fuzz-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-019-unsat-reverse-fuzz-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x ";@H_>hC|FGh3`zU+NscgX\\#\\UH+E8$'j1S6'\x0c',>n;b'54(OqfC8'\r'MnQSezr@9'1")
  Fatal error: exception Failure("TBD")
  TIMEOUT
