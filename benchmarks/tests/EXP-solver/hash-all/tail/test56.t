test56
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test56.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test56 >> test56.smt2
$ cat test56.smt2
  $ timeout 2 Chro test56.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
