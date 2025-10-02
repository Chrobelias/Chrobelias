test45
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test45.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test45 >> test45.smt2
$ cat test45.smt2
  $ timeout 2 Chro test45.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
