test58
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test58.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test58 >> test58.smt2
$ cat test58.smt2
  $ timeout 2 Chro test58.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
