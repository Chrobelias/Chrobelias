test30
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test30.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test30 >> test30.smt2
$ cat test30.smt2
  $ timeout 2 Chro test30.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
