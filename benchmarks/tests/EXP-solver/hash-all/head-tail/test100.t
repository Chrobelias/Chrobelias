test100
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test100.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test100 >> test100.smt2
$ cat test100.smt2
  $ timeout 2 Chro test100.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
