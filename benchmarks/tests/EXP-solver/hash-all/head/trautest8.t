trautest8
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest8.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest8 >> trautest8.smt2
$ cat trautest8.smt2
  $ timeout 2 Chro trautest8.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
