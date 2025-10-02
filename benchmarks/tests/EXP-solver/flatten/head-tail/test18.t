test18
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test18.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test18 >> test18.smt2
$ cat test18.smt2
  $ timeout 2 Chro test18.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
