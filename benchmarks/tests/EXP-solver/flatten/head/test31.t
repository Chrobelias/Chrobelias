test31
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test31.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test31 >> test31.smt2
$ cat test31.smt2
  $ timeout 2 Chro test31.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
