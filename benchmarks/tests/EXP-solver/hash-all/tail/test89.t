test89
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test89.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test89 >> test89.smt2
$ cat test89.smt2
  $ timeout 2 Chro test89.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
