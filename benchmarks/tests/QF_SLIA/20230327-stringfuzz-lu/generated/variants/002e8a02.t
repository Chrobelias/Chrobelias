002e8a02
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/generated/variants/002e8a02.smt2  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception Failure("Unimplemented for string bitvectors")
  TIMEOUT
