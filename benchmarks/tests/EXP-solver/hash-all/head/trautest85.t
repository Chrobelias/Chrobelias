trautest85
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest85.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/all/head/trautest85 >> trautest85.smt2
$ cat trautest85.smt2
  $ timeout 2 Chro trautest85.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
