trautest34
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest34.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest34 >> trautest34.smt2
$ cat trautest34.smt2
  $ timeout 2 Chro trautest34.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
