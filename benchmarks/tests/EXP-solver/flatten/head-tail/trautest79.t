trautest79
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest79.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest79 >> trautest79.smt2
$ cat trautest79.smt2
  $ timeout 2 Chro trautest79.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
