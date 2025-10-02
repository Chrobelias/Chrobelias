trautest29
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest29.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest29 >> trautest29.smt2
$ cat trautest29.smt2
  $ timeout 2 Chro trautest29.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
