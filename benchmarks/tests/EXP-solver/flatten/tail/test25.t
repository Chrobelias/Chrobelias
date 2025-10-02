test25
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test25.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test25 >> test25.smt2
$ cat test25.smt2
  $ timeout 2 Chro test25.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
