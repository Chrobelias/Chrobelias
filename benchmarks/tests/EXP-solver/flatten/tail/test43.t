test43
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test43.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test43 >> test43.smt2
$ cat test43.smt2
  $ timeout 2 Chro test43.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
