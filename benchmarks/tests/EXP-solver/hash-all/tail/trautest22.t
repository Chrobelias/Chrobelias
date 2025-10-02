trautest22
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest22.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest22 >> trautest22.smt2
$ cat trautest22.smt2
  $ timeout 2 Chro trautest22.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
