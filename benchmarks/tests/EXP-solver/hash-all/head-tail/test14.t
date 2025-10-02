test14
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test14.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test14 >> test14.smt2
$ cat test14.smt2
  $ timeout 2 Chro test14.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
