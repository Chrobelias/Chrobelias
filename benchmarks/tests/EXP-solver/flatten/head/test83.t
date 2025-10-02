test83
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test83.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test83 >> test83.smt2
$ cat test83.smt2
  $ timeout 2 Chro test83.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
