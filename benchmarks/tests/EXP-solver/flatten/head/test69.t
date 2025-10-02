test69
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test69.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test69 >> test69.smt2
$ cat test69.smt2
  $ timeout 2 Chro test69.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
