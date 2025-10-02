test9
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test9.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test9 >> test9.smt2
$ cat test9.smt2
  $ timeout 2 Chro test9.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
