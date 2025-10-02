trautest41
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest41.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest41 >> trautest41.smt2
$ cat trautest41.smt2
  $ timeout 2 Chro trautest41.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
