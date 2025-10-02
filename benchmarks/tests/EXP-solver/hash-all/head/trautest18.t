trautest18
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest18.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest18 >> trautest18.smt2
$ cat trautest18.smt2
  $ timeout 2 Chro trautest18.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
