test5
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test5.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test5 >> test5.smt2
$ cat test5.smt2
  $ timeout 2 Chro test5.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
