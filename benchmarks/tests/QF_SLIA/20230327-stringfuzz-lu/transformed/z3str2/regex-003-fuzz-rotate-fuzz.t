regex-003-fuzz-rotate-fuzz
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/transformed/z3str2/regex-003-fuzz-rotate-fuzz.smt2  --no-simpl-alpha  || echo TIMEOUT
  lib/SimplII.ml 292 (= x ".GCqcO&dzWajX*7R}chzg1Co;l4b7oq!'\x0b'}\\ERM1xUSy'\r':aeSZ!'\x0b'yCS\\n{vv/k|_-q7($")
  Fatal error: exception Failure("TBD")
  TIMEOUT
