test80
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test80.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test80 >> test80.smt2
$ cat test80.smt2
  $ timeout 2 Chro test80.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
