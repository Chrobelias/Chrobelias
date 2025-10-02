test40
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test40.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test40 >> test40.smt2
$ cat test40.smt2
  $ timeout 2 Chro test40.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
