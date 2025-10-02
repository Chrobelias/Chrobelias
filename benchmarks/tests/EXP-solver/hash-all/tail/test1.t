test1
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test1.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test1 >> test1.smt2
$ cat test1.smt2
  $ timeout 2 Chro test1.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
