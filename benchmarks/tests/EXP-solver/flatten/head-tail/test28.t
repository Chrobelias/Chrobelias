test28
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test28.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test28 >> test28.smt2
$ cat test28.smt2
  $ timeout 2 Chro test28.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
