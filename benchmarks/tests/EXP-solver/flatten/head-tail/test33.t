test33
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test33.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test33 >> test33.smt2
$ cat test33.smt2
  $ timeout 2 Chro test33.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
