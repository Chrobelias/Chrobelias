test39
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test39.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test39 >> test39.smt2
$ cat test39.smt2
  $ timeout 2 Chro test39.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
