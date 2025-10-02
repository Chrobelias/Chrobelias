trautest7
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest7.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest7 >> trautest7.smt2
$ cat trautest7.smt2
  $ timeout 2 Chro trautest7.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
