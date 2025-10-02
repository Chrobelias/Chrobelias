test84
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test84.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test84 >> test84.smt2
$ cat test84.smt2
  $ timeout 2 Chro test84.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
