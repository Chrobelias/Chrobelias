b7d1c3aa
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/generated/variants/b7d1c3aa.smt2  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception Failure("Unimplemented for string bitvectors")
  TIMEOUT
