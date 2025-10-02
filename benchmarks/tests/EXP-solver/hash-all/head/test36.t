test36
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test36.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test36 >> test36.smt2
$ cat test36.smt2
  $ timeout 2 Chro test36.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
