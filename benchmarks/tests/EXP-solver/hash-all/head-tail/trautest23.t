trautest23
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest23.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest23 >> trautest23.smt2
$ cat trautest23.smt2
  $ timeout 2 Chro trautest23.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
