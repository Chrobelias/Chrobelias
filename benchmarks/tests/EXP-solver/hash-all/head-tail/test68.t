test68
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test68.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test68 >> test68.smt2
$ cat test68.smt2
  $ timeout 2 Chro test68.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
