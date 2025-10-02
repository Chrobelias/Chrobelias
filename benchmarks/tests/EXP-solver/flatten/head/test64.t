test64
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test64.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test64 >> test64.smt2
$ cat test64.smt2
  $ timeout 2 Chro test64.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
