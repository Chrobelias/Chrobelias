trautest70
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest70.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest70 >> trautest70.smt2
$ cat trautest70.smt2
  $ timeout 2 Chro trautest70.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
