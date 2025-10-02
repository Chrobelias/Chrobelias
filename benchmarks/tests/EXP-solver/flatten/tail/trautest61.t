trautest61
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest61.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest61 >> trautest61.smt2
$ cat trautest61.smt2
  $ timeout 2 Chro trautest61.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
