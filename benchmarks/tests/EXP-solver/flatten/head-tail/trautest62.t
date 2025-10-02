trautest62
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest62.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest62 >> trautest62.smt2
$ cat trautest62.smt2
  $ timeout 2 Chro trautest62.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
