test12
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test12.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test12 >> test12.smt2
$ cat test12.smt2
  $ timeout 2 Chro test12.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
