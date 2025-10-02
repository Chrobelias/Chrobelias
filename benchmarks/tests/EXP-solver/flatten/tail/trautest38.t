trautest38
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest38.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest38 >> trautest38.smt2
$ cat trautest38.smt2
  $ timeout 2 Chro trautest38.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
