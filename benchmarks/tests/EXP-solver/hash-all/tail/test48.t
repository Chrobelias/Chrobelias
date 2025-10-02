test48
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test48.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test48 >> test48.smt2
$ cat test48.smt2
  $ timeout 2 Chro test48.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
