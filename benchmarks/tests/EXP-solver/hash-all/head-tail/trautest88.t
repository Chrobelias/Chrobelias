trautest88
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest88.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest88 >> trautest88.smt2
$ cat trautest88.smt2
  $ timeout 2 Chro trautest88.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
