test70
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test70.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/test70 >> test70.smt2
$ cat test70.smt2
  $ timeout 2 Chro test70.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
