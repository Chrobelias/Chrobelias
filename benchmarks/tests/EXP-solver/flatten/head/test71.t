test71
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test71.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test71 >> test71.smt2
$ cat test71.smt2
  $ timeout 2 Chro test71.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
