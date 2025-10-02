trautest72
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest72.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest72 >> trautest72.smt2
$ cat trautest72.smt2
  $ timeout 2 Chro trautest72.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
