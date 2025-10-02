test98
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test98.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test98 >> test98.smt2
$ cat test98.smt2
  $ timeout 2 Chro test98.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
