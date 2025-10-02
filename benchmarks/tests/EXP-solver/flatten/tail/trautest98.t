trautest98
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest98.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest98 >> trautest98.smt2
$ cat trautest98.smt2
  $ timeout 2 Chro trautest98.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
