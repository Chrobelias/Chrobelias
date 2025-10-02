test82
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test82.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test82 >> test82.smt2
$ cat test82.smt2
  $ timeout 2 Chro test82.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
