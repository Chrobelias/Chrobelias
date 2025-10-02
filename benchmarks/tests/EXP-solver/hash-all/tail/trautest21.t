trautest21
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest21.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest21 >> trautest21.smt2
$ cat trautest21.smt2
  $ timeout 2 Chro trautest21.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
