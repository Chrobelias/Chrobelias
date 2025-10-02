trautest99
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest99.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest99 >> trautest99.smt2
$ cat trautest99.smt2
  $ timeout 2 Chro trautest99.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
