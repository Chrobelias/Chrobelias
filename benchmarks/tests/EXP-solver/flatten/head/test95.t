test95
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test95.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test95 >> test95.smt2
$ cat test95.smt2
  $ timeout 2 Chro test95.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
