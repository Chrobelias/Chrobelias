test23
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test23.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test23 >> test23.smt2
$ cat test23.smt2
  $ timeout 2 Chro test23.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
