test6
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test6.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test6 >> test6.smt2
$ cat test6.smt2
  $ timeout 2 Chro test6.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
