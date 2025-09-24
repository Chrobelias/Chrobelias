b420e5ed
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../../benchmarks/QF_SLIA/20230327-stringfuzz-lu/generated/variants/b420e5ed.smt2  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception Failure("string constraints are not supported in EIA mode")
  TIMEOUT
