test44
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test44.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test44 >> test44.smt2
$ cat test44.smt2
  $ timeout 2 Chro test44.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
