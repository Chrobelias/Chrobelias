test34
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test34  --no-simpl-alpha  || echo TIMEOUT
  Fatal error: exception Failure("string constraints are not supported in EIA mode")
  TIMEOUT
