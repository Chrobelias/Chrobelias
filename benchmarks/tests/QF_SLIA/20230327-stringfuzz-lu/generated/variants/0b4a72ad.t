0b4a72ad
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/generated/variants/0b4a72ad.smt2  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception Failure("Unimplemented for string bitvectors")
  TIMEOUT
