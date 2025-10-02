test16
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test16.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test16 >> test16.smt2
$ cat test16.smt2
  $ timeout 2 Chro test16.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
