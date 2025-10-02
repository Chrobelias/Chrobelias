test55
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test55.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test55 >> test55.smt2
$ cat test55.smt2
  $ timeout 2 Chro test55.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
