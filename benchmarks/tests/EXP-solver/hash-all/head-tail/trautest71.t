trautest71
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest71.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest71 >> trautest71.smt2
$ cat trautest71.smt2
  $ timeout 2 Chro trautest71.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
