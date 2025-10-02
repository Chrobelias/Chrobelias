test22
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test22.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test22 >> test22.smt2
$ cat test22.smt2
  $ timeout 2 Chro test22.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
