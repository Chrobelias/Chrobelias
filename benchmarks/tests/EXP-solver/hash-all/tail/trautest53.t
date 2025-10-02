trautest53
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest53.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest53 >> trautest53.smt2
$ cat trautest53.smt2
  $ timeout 2 Chro trautest53.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
