test38
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test38.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test38 >> test38.smt2
$ cat test38.smt2
  $ timeout 2 Chro test38.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
