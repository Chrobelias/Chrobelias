test62
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test62.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test62 >> test62.smt2
$ cat test62.smt2
  $ timeout 2 Chro test62.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
