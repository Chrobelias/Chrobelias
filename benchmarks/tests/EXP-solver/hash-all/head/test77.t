test77
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > test77.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/test77 >> test77.smt2
$ cat test77.smt2
  $ timeout 2 Chro test77.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
