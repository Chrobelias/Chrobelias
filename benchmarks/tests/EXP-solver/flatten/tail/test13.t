test13
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test13.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test13 >> test13.smt2
$ cat test13.smt2
  $ timeout 2 Chro test13.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
