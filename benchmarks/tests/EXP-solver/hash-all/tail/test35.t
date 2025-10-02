test35
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test35.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test35 >> test35.smt2
$ cat test35.smt2
  $ timeout 2 Chro test35.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
