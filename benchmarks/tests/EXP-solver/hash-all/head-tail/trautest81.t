trautest81
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest81.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest81 >> trautest81.smt2
$ cat trautest81.smt2
  $ timeout 2 Chro trautest81.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
