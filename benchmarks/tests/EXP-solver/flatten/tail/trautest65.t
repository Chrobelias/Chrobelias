trautest65
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest65.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest65 >> trautest65.smt2
$ cat trautest65.smt2
  $ timeout 2 Chro trautest65.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
