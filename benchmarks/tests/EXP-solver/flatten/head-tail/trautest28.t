trautest28
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest28.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest28 >> trautest28.smt2
$ cat trautest28.smt2
  $ timeout 2 Chro trautest28.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
