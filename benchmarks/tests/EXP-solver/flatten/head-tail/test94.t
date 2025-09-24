test94
  $ export OCAMLRUNPARAM='b=0'
  $ timeout 2 Chro ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test94  || echo TIMEOUT
  Fatal error: exception Failure("expected term, in (none.rem_s (none.rem_s (str.to_int x) 575053) 298299)")
  TIMEOUT
