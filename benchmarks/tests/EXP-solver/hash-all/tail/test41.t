test41
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test41.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test41 >> test41.smt2
$ cat test41.smt2
  $ timeout 2 Chro test41.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
