test37
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test37.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test37 >> test37.smt2
$ cat test37.smt2
  $ timeout 2 Chro test37.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
