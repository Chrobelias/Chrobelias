trautest82
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest82.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest82 >> trautest82.smt2
$ cat trautest82.smt2
  $ timeout 2 Chro trautest82.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
