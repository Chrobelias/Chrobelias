test67
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test67.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test67 >> test67.smt2
$ cat test67.smt2
  $ timeout 2 Chro test67.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
