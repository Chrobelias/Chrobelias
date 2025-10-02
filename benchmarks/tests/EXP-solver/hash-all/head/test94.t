test94
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test94.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test94 >> test94.smt2
$ cat test94.smt2
  $ timeout 2 Chro test94.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
