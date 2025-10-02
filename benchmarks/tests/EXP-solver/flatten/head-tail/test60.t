test60
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test60.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test60 >> test60.smt2
$ cat test60.smt2
  $ timeout 2 Chro test60.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
