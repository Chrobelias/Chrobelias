test2
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test2.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test2 >> test2.smt2
$ cat test2.smt2
  $ timeout 2 Chro test2.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
