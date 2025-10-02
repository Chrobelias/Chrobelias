trautest33
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest33.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest33 >> trautest33.smt2
$ cat trautest33.smt2
  $ timeout 2 Chro trautest33.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
