test42
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test42.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test42 >> test42.smt2
$ cat test42.smt2
  $ timeout 2 Chro test42.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
