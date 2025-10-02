trautest50
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest50.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest50 >> trautest50.smt2
$ cat trautest50.smt2
  $ timeout 2 Chro trautest50.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
