test97
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test97.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test97 >> test97.smt2
$ cat test97.smt2
  $ timeout 2 Chro test97.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
