test19
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test19.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test19 >> test19.smt2
$ cat test19.smt2
  $ timeout 2 Chro test19.smt2  || echo TIMEOUT
  sat ; nfa
  timeout
  TIMEOUT
