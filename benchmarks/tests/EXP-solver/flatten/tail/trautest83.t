trautest83
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest83.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest83 >> trautest83.smt2
$ cat trautest83.smt2
  $ timeout 2 Chro trautest83.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
