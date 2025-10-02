test11
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test11.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test11 >> test11.smt2
$ cat test11.smt2
  $ timeout 2 Chro test11.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
