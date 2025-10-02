test73
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test73.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test73 >> test73.smt2
$ cat test73.smt2
  $ timeout 2 Chro test73.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
