test4
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test4.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test4 >> test4.smt2
$ cat test4.smt2
  $ timeout 2 Chro test4.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
