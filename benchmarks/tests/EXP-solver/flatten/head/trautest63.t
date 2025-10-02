trautest63
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest63.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest63 >> trautest63.smt2
$ cat trautest63.smt2
  $ timeout 2 Chro trautest63.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
