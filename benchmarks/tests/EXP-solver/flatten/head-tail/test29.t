test29
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test29.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test29 >> test29.smt2
$ cat test29.smt2
  $ timeout 2 Chro test29.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
