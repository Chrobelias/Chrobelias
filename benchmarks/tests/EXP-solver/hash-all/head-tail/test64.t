test64
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test64  --no-simpl-alpha  || echo TIMEOUT
  timeout
  TIMEOUT
