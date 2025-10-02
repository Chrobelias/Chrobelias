trautest75
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest75.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest75 >> trautest75.smt2
$ cat trautest75.smt2
  $ timeout 2 Chro trautest75.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
