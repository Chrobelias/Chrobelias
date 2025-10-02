trautest27
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest27.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest27 >> trautest27.smt2
$ cat trautest27.smt2
  $ timeout 2 Chro trautest27.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
