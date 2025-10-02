trautest78
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest78.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest78 >> trautest78.smt2
$ cat trautest78.smt2
  $ timeout 2 Chro trautest78.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
