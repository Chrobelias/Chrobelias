test91
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test91.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test91 >> test91.smt2
$ cat test91.smt2
  $ timeout 2 Chro test91.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
