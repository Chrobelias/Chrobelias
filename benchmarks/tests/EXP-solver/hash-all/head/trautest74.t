trautest74
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest74.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest74 >> trautest74.smt2
$ cat trautest74.smt2
  $ timeout 2 Chro trautest74.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
