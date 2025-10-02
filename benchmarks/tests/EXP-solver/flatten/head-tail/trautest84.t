trautest84
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest84.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest84 >> trautest84.smt2
$ cat trautest84.smt2
  $ timeout 2 Chro trautest84.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
