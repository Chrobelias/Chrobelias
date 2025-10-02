test57
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test57.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test57 >> test57.smt2
$ cat test57.smt2
  $ timeout 2 Chro test57.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
