test66
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test66.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test66 >> test66.smt2
$ cat test66.smt2
  $ timeout 2 Chro test66.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
