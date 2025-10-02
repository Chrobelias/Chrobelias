test63
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test63.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test63 >> test63.smt2
$ cat test63.smt2
  $ timeout 2 Chro test63.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
