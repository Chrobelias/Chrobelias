test72
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test72.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test72 >> test72.smt2
$ cat test72.smt2
  $ timeout 2 Chro test72.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
