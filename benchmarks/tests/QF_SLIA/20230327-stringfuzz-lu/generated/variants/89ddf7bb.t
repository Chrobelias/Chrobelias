89ddf7bb
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/generated/variants/89ddf7bb.smt2  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception Failure("Unimplemented for string bitvectors")
  TIMEOUT
