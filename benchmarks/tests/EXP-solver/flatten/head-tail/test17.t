test17
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test17.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test17 >> test17.smt2
$ cat test17.smt2
  $ timeout 2 Chro test17.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
