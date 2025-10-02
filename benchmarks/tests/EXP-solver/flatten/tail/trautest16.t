trautest16
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest16.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest16 >> trautest16.smt2
$ cat trautest16.smt2
  $ timeout 2 Chro trautest16.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
