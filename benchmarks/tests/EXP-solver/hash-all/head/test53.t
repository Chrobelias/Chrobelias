test53
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test53.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test53 >> test53.smt2
$ cat test53.smt2
  $ timeout 2 Chro test53.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
