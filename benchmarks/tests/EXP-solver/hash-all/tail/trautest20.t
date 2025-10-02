trautest20
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest20.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest20 >> trautest20.smt2
$ cat trautest20.smt2
  $ timeout 2 Chro trautest20.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
