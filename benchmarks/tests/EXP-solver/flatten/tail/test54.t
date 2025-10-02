test54
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test54.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test54 >> test54.smt2
$ cat test54.smt2
  $ timeout 2 Chro test54.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
