test24
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test24.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test24 >> test24.smt2
$ cat test24.smt2
  $ timeout 2 Chro test24.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
