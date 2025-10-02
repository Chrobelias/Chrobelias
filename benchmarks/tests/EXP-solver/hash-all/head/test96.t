test96
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test96.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test96 >> test96.smt2
$ cat test96.smt2
  $ timeout 2 Chro test96.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
