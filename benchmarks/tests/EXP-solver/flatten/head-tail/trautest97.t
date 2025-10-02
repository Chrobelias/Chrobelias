trautest97
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest97.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest97 >> trautest97.smt2
$ cat trautest97.smt2
  $ timeout 2 Chro trautest97.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
