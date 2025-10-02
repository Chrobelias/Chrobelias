test61
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test61.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test61 >> test61.smt2
$ cat test61.smt2
  $ timeout 2 Chro test61.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
