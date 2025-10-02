test59
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test59.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test59 >> test59.smt2
$ cat test59.smt2
  $ timeout 2 Chro test59.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
