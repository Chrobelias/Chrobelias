test79
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test79.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test79 >> test79.smt2
$ cat test79.smt2
  $ timeout 2 Chro test79.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
