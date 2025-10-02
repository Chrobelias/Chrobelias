trautest30
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest30.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest30 >> trautest30.smt2
$ cat trautest30.smt2
  $ timeout 2 Chro trautest30.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
