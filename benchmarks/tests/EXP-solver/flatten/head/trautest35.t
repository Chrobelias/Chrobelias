trautest35
  $ export OCAMLRUNPARAM='b=0'
  $ printf '(set-logic QF_S)\n' > trautest35.smt2
  $ grep -v set-logic ../../../../../benchmarks/EXP-solver/Benchmark/HashFunction/flatten/head/trautest35 >> trautest35.smt2
$ cat trautest35.smt2
  $ timeout 2 Chro trautest35.smt2  || echo TIMEOUT
  timeout
  TIMEOUT
