test50
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test50.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test50 >> test50.smt2
$ cat test50.smt2
  $ timeout 2 Chro test50.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
