test81
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test81.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test81 >> test81.smt2
$ cat test81.smt2
  $ timeout 2 Chro test81.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
