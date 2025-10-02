test78
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test78.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test78 >> test78.smt2
$ cat test78.smt2
  $ timeout 2 Chro test78.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
