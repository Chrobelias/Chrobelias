trautest66
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest66.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest66 >> trautest66.smt2
$ cat trautest66.smt2
  $ timeout 2 Chro trautest66.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
