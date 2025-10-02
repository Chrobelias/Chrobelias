trautest1
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest1.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest1 >> trautest1.smt2
$ cat trautest1.smt2
  $ timeout 2 Chro trautest1.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
