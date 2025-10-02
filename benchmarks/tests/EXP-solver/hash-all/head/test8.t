test8
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test8.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test8 >> test8.smt2
$ cat test8.smt2
  $ timeout 2 Chro test8.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
