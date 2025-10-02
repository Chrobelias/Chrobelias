test32
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test32.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test32 >> test32.smt2
$ cat test32.smt2
  $ timeout 2 Chro test32.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
