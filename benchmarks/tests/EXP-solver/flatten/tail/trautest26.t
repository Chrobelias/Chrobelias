trautest26
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest26.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest26 >> trautest26.smt2
$ cat trautest26.smt2
  $ timeout 2 Chro trautest26.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
