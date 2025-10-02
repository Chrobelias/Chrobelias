test87
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test87.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test87 >> test87.smt2
$ cat test87.smt2
  $ timeout 2 Chro test87.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
