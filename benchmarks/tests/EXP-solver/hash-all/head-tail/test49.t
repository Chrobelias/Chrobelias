test49
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test49.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test49 >> test49.smt2
$ cat test49.smt2
  $ timeout 2 Chro test49.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
