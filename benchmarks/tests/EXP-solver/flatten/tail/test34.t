test34
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test34.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test34 >> test34.smt2
$ cat test34.smt2
  $ timeout 2 Chro test34.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
