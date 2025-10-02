test3
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test3.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test3 >> test3.smt2
$ cat test3.smt2
  $ timeout 2 Chro test3.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
