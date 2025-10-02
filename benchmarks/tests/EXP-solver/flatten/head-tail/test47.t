test47
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test47.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test47 >> test47.smt2
$ cat test47.smt2
  $ timeout 2 Chro test47.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
