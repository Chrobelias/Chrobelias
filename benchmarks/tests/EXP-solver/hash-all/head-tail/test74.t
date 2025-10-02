test74
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test74.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test74 >> test74.smt2
$ cat test74.smt2
  $ timeout 2 Chro test74.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
