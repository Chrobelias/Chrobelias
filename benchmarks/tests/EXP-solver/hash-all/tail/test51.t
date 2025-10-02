test51
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test51.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test51 >> test51.smt2
$ cat test51.smt2
  $ timeout 2 Chro test51.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
