test20
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test20.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test20 >> test20.smt2
$ cat test20.smt2
  $ timeout 2 Chro test20.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
