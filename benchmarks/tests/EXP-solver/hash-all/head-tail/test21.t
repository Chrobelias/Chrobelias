test21
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test21.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test21 >> test21.smt2
$ cat test21.smt2
  $ timeout 2 Chro test21.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
