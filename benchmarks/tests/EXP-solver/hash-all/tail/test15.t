test15
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test15.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test15 >> test15.smt2
$ cat test15.smt2
  $ timeout 2 Chro test15.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
