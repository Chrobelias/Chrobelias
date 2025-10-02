trautest45
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest45.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest45 >> trautest45.smt2
$ cat trautest45.smt2
  $ timeout 2 Chro trautest45.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
