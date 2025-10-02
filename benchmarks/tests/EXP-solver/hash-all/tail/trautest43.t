trautest43
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest43.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest43 >> trautest43.smt2
$ cat trautest43.smt2
  $ timeout 2 Chro trautest43.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
