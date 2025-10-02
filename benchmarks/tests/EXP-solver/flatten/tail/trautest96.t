trautest96
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest96.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest96 >> trautest96.smt2
$ cat trautest96.smt2
  $ timeout 2 Chro trautest96.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
