trautest14
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest14.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest14 >> trautest14.smt2
$ cat trautest14.smt2
  $ timeout 2 Chro trautest14.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
