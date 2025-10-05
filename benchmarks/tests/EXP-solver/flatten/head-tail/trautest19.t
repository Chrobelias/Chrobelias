trautest19
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest19.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest19 >> trautest19.smt2
$ cat trautest19.smt2
  $ timeout 2 Chro trautest19.smt2  || echo TIMEOUT
  sat ; nfa
  timeout
  TIMEOUT
