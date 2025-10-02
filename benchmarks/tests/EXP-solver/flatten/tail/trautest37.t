trautest37
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest37.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest37 >> trautest37.smt2
$ cat trautest37.smt2
  $ timeout 2 Chro trautest37.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
