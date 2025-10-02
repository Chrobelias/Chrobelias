test93
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test93.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test93 >> test93.smt2
$ cat test93.smt2
  $ timeout 2 Chro test93.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
