test76
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test76.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test76 >> test76.smt2
$ cat test76.smt2
  $ timeout 2 Chro test76.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
