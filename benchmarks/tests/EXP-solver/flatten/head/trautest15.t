trautest15
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest15.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest15 >> trautest15.smt2
$ cat trautest15.smt2
  $ timeout 2 Chro trautest15.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
