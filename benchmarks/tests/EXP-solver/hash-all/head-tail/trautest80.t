trautest80
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest80.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest80 >> trautest80.smt2
$ cat trautest80.smt2
  $ timeout 2 Chro trautest80.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
