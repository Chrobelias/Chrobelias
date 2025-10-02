test99
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test99.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test99 >> test99.smt2
$ cat test99.smt2
  $ timeout 2 Chro test99.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
