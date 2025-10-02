trautest42
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest42.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest42 >> trautest42.smt2
$ cat trautest42.smt2
  $ timeout 2 Chro trautest42.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
