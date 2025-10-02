test65
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test65.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test65 >> test65.smt2
$ cat test65.smt2
  $ timeout 2 Chro test65.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
