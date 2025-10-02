trautest73
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest73.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest73 >> trautest73.smt2
$ cat trautest73.smt2
  $ timeout 2 Chro trautest73.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
