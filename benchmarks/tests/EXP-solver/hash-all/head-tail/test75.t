test75
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test75.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test75 >> test75.smt2
$ cat test75.smt2
  $ timeout 2 Chro test75.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
